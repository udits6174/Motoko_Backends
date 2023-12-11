import Card from "../components/Card";
//sample query data; actual data will be fetched from canister
let queryData = [
  {
    hackathon_name: "BlockBash '23",
    event_img_url: "https://th.bing.com/th/id/OIP.IYutKgeTsRQREp8v5kzd6gHaE8?w=257&h=180&c=7&r=0&o=5&dpr=1.7&pid=1.7",
    location: "Bengaluru",
    hackathon_details: "Bangalore, often referred to as the 'Silicon Valley of India,' boasts a plethora of world-class colleges and educational institutions. Renowned for its vibrant academic atmosphere, the city offers a diverse range of colleges spanning various disciplines. Institutions like the Indian Institute of Science (IISc) and Indian Institute of Technology (IIT) Bangalore are globally recognized for their research and innovation. Bangalore's colleges also excel in fields like engineering, management, medicine, and liberal arts, attracting students from across India and beyond. The city's cosmopolitan culture, excellent faculty, and cutting-edge infrastructure make it a prime destination for higher education and professional growth.",
    hackathon_start: "21 June, 2023",
    organiser_name: "Dfinity Foundation",
    id: 0,
  },
  {
    hackathon_name: "HackFest ISM '23",
    event_img_url: "https://th.bing.com/th/id/OIP.7YRGMfw7rRb8hRBX85rN3QHaEK?rs=1&pid=ImgDetMain",
    location: "Dhanbad",
    hackathon_details:
      "The Indian Institute of Technology (Indian School of Mines) constituted under Institute of Technology Act, 1961 is administered through IIT Council-the apex body, Government of India under the Chairmanship of Honourable Minister, MoE for uniform and smooth governance of Pan-IIT in our country.To be a nationally and internationally acclaimed premier institution of higher technical and scientific education with social commitment having an ethos for intellectual excellence, where initiative is nurtured, where new ideas, research and scholarship flourish, where intellectual honesty is the norm and from which will emerge the leaders and innovators of tomorrow in the realm of technology.",
    hackathon_start: "12 Dec, 2023",
    organiser_name: "Crewsphere",
    id: 1,
  },
];

const Register = () => {
  return (
    <>
      <div className="cards">
        {queryData.map((ele, ind) => {
          console.log(ele);
          return(<Card
            key={ind}
            hackathonName={ele.hackathon_name}
            eventImgUrl={ele.event_img_url}
            location={ele.location}
            hackathonDetails={ele.hackathon_details}
            hackathonStart={ele.hackathon_start}
            organiserName={ele.organiser_name}
            eventId={ele.id}
          />)
        })}
      </div>
    </>
  );
};

export default Register;
