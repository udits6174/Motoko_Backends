import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Result "mo:base/Result";

shared ({ caller }) actor class LexiVault() {

  type quoteToLawyer = {
    client : Principal;
    clientName : Text;
    caseType : Text; //civil, criminal etc
    caseAgainst : Text; //the other party
    caseBriefs : Text;
    InstrumentURI : Text; //ipfs uri to view instruments(wills and deeds) in favor
    dateTentative : Text;
  };

  let principalComp : (Principal, Principal) -> Bool = func(x, y) { x == y };
  let principalHash : Principal -> Hash.Hash = Principal.hash;

  var dataArray  = Buffer.Buffer<quoteToLawyer>(1);
  var authBuffer = Buffer.Buffer<Nat32>(1);
  var lawyerRequested = HashMap.HashMap<Principal, Buffer.Buffer<quoteToLawyer>>(99, principalComp, principalHash);
  var lawyerAccepted = HashMap.HashMap<Principal, Buffer.Buffer<quoteToLawyer>>(99, principalComp, principalHash);

  //Create a request to specific Lawyer
  public shared ({ caller }) func createReqToLawyer(data : [Text]) : async Result.Result<Text, Text>{

    //Reject users with anonymous Identities
    if(Principal.isAnonymous(caller)){
      return #err("Anonymous persons can't register, please login with wallet or internet identity");
    };
    //
    let thisCase : quoteToLawyer = {
      client = caller;
      clientName = data[1];
      caseType = data[2];
      caseAgainst = data[3];
      caseBriefs = data[4];
      InstrumentURI = data[5];
      dateTentative = data[6];
    };

    let lawyerPrincipal = Principal.fromText(data[0]);
    switch (lawyerRequested.get(lawyerPrincipal)) {
      case (null) {
        // If the key does not exist in the HashMap, create a new buffer and add the data
        let newBuffer = Buffer.Buffer<quoteToLawyer>(1);
        newBuffer.add(thisCase);
        lawyerRequested.put(lawyerPrincipal, newBuffer);
      };
      case (?existingBuffer) {
        // If the key exists, append the data to the existing buffer
        existingBuffer.add(thisCase);
        lawyerRequested.put(lawyerPrincipal, existingBuffer);
      };
    };
    dataArray.add(thisCase);
    #ok("Successfully requested the case to Lawyer");
  };

  //Query: All cases
  public shared query func getAllCases() : async [quoteToLawyer]{
    let allCases = Buffer.toArray<quoteToLawyer>(dataArray);
    return allCases;
  };
  //Query: requested cases
  public shared query ({ caller }) func getRequests() : async [quoteToLawyer] {
    switch (lawyerRequested.get(caller)) {
      case (null) {
        return [];
      };
      case (?buffer) {
        let array = Buffer.toArray<quoteToLawyer>(buffer);
        // Debug.print(debug_show(array));
        return array;
      };
    };
  };
  //Query: Accepted cases
  public shared query ({ caller }) func getAccepted() : async [quoteToLawyer] {
    switch (lawyerAccepted.get(caller)) {
      case (null) {
        return [];
      };
      case (?buffer) {
        return Buffer.toArray<quoteToLawyer>(buffer);
      };
    };
  };

  
  //hash function for user-lawyer window
  private func hashPrincipals(principal1: Principal, principal2: Principal, seed: Text): async Nat32 {
    let text1 = Principal.toText(principal1);
    let text2 = Principal.toText(principal2);
    let textValue = Text.concat(text2, text1);
    let textValue2 = Text.concat(textValue, seed);
    let hashValue: Hash.Hash = Text.hash(textValue2);
    return hashValue;
  };
    //Lawyer accepts the case
  public shared ({ caller }) func acceptCase(clientId : Principal, seed : Nat32) : async Nat32 {
    var thisCase : ?quoteToLawyer = null;
    switch (lawyerRequested.get(caller)) {
      case (null) {
        return 0;
      };
      case (?existingRequestBuffer) {
        //If there are requests, search in the existing buffer
        Buffer.iterate<quoteToLawyer>(
          existingRequestBuffer, func(request : quoteToLawyer) {
            if (request.client == clientId) {
              thisCase := ?request;
            };
          },
        );
        switch (thisCase) {
          case (null) {
            // Handle the case where thisCase is null
            return 0;
          };
          case (?thisCase) {
            switch (lawyerAccepted.get(caller)) {
              case (null) {
                let newBuffer = Buffer.Buffer<quoteToLawyer>(1);
                newBuffer.add(thisCase);
                lawyerRequested.put(caller, newBuffer);
              };
              case (?existingBuffer) {
                existingBuffer.add(thisCase);
                lawyerRequested.put(caller, existingBuffer);
              };
            };
            let seed = Text.concat(thisCase.caseBriefs, thisCase.InstrumentURI);
            let hashVal: Nat32 = await hashPrincipals(thisCase.client, caller, seed);
            authBuffer.add(hashVal);
            return hashVal;
          };
        };
      };
    };
  };
  
  //Password matching logic for UNIQUE CASE WINDOW LOGIN
  public query func caseLogin(pw: Nat32): async Bool {
    var isMatch: Bool = false;
    Buffer.iterate<Nat32>(
          authBuffer, func(el : Nat32) {
            if (el == pw) {
              isMatch := true;
            };
          },
        );
    return isMatch;
  }
};
