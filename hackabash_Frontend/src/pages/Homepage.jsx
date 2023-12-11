import "./homepage.css";
import { NavLink } from "react-router-dom";

const Homepage = () => {
  return (
    <>
      <main>
        <h1>We are Hackabash: Your Innovation Partner</h1>
        <p>
          Launch, organise and participate in hackathons. Unfold the potential
          of collective creativity.
        </p>
        <div className="buttons">
          <NavLink exact to="/register" style={{ textDecoration: 'none' }}>
            <button id="register">Register for a Hackathon</button>
          </NavLink>
          <NavLink exact to="/organise" style={{ textDecoration: 'none' }}>
            <button id="organise">Organise a Hackathon</button>
          </NavLink>
        </div>
      </main>
    </>
  );
};

export default Homepage;
