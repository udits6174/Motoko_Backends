import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";
import TrieMap "mo:base/TrieMap";

actor {
  //Variables
  stable var hackathon_id : Nat = 0;
  //Types
  type Hackathon = {
    id : Nat;
    organiser_name : Text;
    organiser_details : Text;
    organiser_email : Text;
    hackathon_details : Text; //set of rules and regulations, tracks and themes
    registration_start : Text;
    registration_end : Text;
    hackathon_start : Text;
    hackathon_end : Text;
    pool_prize : Nat;
  };

  let principalComp : (Principal, Principal) -> Bool = func(x, y) { x == y };
  let principalHash : Principal -> Hash.Hash = Principal.hash;

  //Data structures
  var allHackathons = Buffer.Buffer<Hackathon>(0);
  let idToHackathon = TrieMap.TrieMap<Nat, Hackathon>(Nat.equal, Hash.hash);
  let idToOrganiser = TrieMap.TrieMap<Nat, Principal>(Nat.equal, Hash.hash);
  let organiserToParticipants = TrieMap.TrieMap<Principal, Buffer.Buffer<Principal>>(principalComp, principalHash);
  //Function to list a hackathon by an organisation
  public shared ({ caller }) func listHackathon(
    _organiser_name : Text,
    _organiser_details : Text,
    _organiser_email : Text,
    _hackathon_details : Text,
    _registration_start : Text,
    _registration_end : Text,
    _hackathon_start : Text,
    _hackathon_end : Text,
    _pool_prize : Nat,
  ) : async Result.Result<Text, Text> {
    // Check if the caller is anonymous
    // if (Principal.isAnonymous(caller)) {
    //   return #err("Anonymous persons can't list a hackathon, please login with wallet or internet identity");
    // };
    let thisHackathon : Hackathon = {
      id = hackathon_id;
      organiser_name = _organiser_name;
      organiser_details = _organiser_details;
      organiser_email = _organiser_email;
      hackathon_details = _hackathon_details;
      registration_start = _registration_start;
      registration_end = _registration_end;
      hackathon_start = _hackathon_start;
      hackathon_end = _hackathon_end;
      pool_prize = _pool_prize;
    };
    //register this hackathon
    allHackathons.add(thisHackathon);
    idToHackathon.put(hackathon_id, thisHackathon);
    idToOrganiser.put(hackathon_id,caller);
    hackathon_id := hackathon_id + 1;
    #ok("Successfully added your hackathon");
  };
  //Register for a Hackathon by id
  public shared ({ caller }) func register(hack_id : Nat) : async Result.Result<Text, Text> {
    // Check if the caller is anonymous
    // if (Principal.isAnonymous(caller)) {
    //   return #err("Anonymous persons can't register, please login with wallet or internet identity");
    // };
    switch (idToOrganiser.get(hack_id)) {
      case (null) {
        return #err("No organiser found for this id");
      };
      case (?organiser) {
        switch (organiserToParticipants.get(organiser)) {
          case (null) {
            let newBuffer = Buffer.Buffer<Principal>(1);
            newBuffer.add(caller);
            organiserToParticipants.put(organiser, newBuffer);
            return #ok("Successfully registered in the hackathon");
          };
          case (?existingParticipants) {
            existingParticipants.add(caller);
            return #ok("Successfully registered in the hackathon");
          };
        };
      };
    };
  };

  //get hackathon by id
  public func getHackathonById(hack_id : Nat) : async Result.Result<Hackathon, Text> {
    switch (idToHackathon.get(hack_id)) {
      case (null) {
        return #err("No such hackathon listed");
      };
      case (?hackathon) {
        return #ok(hackathon);
      };
    };
  };
  //get all hackathons details
  public query func getAllHackathons() : async [Hackathon] {
    let allHackathonsArr = Buffer.toArray<Hackathon>(allHackathons);
    return allHackathonsArr;
  };
  //get all registered users
  public shared query({ caller }) func getParticipants(hack_id : Nat) : async Result.Result<[Principal], Text> {

    switch (idToOrganiser.get(hack_id)) {
      case (null) { return #err("No such organiser found") };
      case (?organiser) {
        switch (Principal.toText(organiser) == Principal.toText(caller)) {
          case (false) { return #err("No hackathons listed by caller") };
          case (true) {
            switch (organiserToParticipants.get(organiser)) {
              case (null) { return #err("No participants yet") };
              case (?participants) { return #ok(Buffer.toArray<Principal>(participants)); };
            };
          };
        };
      };
    };
  };
};
