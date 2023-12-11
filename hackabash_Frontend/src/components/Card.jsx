import "./card.css";

const Card = ({hackathonName, eventImgUrl, location, hackathonDetails, hackathonStart, organiserName, eventId}) => {
  return (
    <>
      <div className="card">
        <div className="card-header">
          <h1 className="card-title" style={{ fontSize: '2.5rem' }}>{hackathonName}</h1>
        </div>
        <div className="card-body">
          <div className="card-image">
            <img
              src={eventImgUrl}
              alt="event image"
            />
            <h2 className="card-location" >{location}</h2>
          </div>
          <div className="card-content">
            <p className="card-text">
              {hackathonDetails.slice(0,256)}...
            </p>
            <div className="card-date">
            <h2>{hackathonStart.slice(0, -4)} &nbsp;,</h2>
              <h2>{hackathonStart.slice(-4)}</h2>
            </div>
            <div className="card-company">
              <h2>Powered by: &nbsp; </h2>
              <h2> {organiserName}</h2>
            </div>
            <button className="card-button">Apply now</button>
          </div>
        </div>
      </div>
    </>
  );
};

export default Card;
