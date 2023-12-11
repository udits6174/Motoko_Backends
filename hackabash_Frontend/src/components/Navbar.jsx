import { NavLink } from "react-router-dom";
import "./navbar.css";

const Navbar = () => {
  return (
    <>
      <nav className="navbar">
        <div className="nav-content">
          <NavLink exact to="/" className="nav-logo">
            <img src="src\assets\hackabash_logo.png" alt="Logo" />
          </NavLink>
        </div>
      </nav>
    </>
  );
};

export default Navbar;
