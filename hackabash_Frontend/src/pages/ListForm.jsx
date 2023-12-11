import React from "react";
import { useState } from "react";
import "./listform.css";

const ListForm = () => {
  const [formValues, setFormValues] = useState({
    organiserName: "",
    organiserDetails: "",
    organiserEmail: "",
    hackathonDetails: "",
    registrationStart: "",
    registrationEnd: "",
    hackathonStart: "",
    hackathonEnd: "",
    poolPrize: 0,
  });

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormValues((prevValues) => ({
      ...prevValues,
      [name]: value,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(formValues);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>List a hackathon</h2>
      <label htmlFor="organiserName">Organiser Name:</label>
      <input
        type="text"
        id="organiserName"
        name="organiserName"
        value={formValues.organiserName}
        onChange={handleChange}
      />

      <label htmlFor="organiserDetails">Organiser Details:</label>
      <textarea
        id="organiserDetails"
        name="organiserDetails"
        value={formValues.organiserDetails}
        onChange={handleChange}
      />

      <label htmlFor="organiserEmail">Organiser Email:</label>
      <input
        type="email"
        id="organiserEmail"
        name="organiserEmail"
        value={formValues.organiserEmail}
        onChange={handleChange}
      />

      <label htmlFor="hackathonDetails">Hackathon Details:</label>
      <textarea
        id="hackathonDetails"
        name="hackathonDetails"
        value={formValues.hackathonDetails}
        onChange={handleChange}
      />

      <label htmlFor="location">Location:</label>
      <input
        type="text"
        id="location"
        name="location"
        value={formValues.location}
        onChange={handleChange}
      />

      <label htmlFor="registrationStart">Registration Start:</label>
      <input
        type="text"
        id="registrationStart"
        name="registrationStart"
        value={formValues.registrationStart}
        onChange={handleChange}
      />

      <label htmlFor="registrationEnd">Registration End:</label>
      <input
        type="text"
        id="registrationEnd"
        name="registrationEnd"
        value={formValues.registrationEnd}
        onChange={handleChange}
      />

      <label htmlFor="hackathonStart">Hackathon Start:</label>
      <input
        type="text"
        id="hackathonStart"
        name="hackathonStart"
        value={formValues.hackathonStart}
        onChange={handleChange}
      />

      <label htmlFor="hackathonEnd">Hackathon End:</label>
      <input
        type="text"
        id="hackathonEnd"
        name="hackathonEnd"
        value={formValues.hackathonEnd}
        onChange={handleChange}
      />

      <label htmlFor="poolPrize">Pool Prize:</label>
      <input
        type="number"
        id="poolPrize"
        name="poolPrize"
        value={formValues.poolPrize}
        onChange={handleChange}
      />

      <button type="submit">Submit</button>
    </form>
  );
};

export default ListForm;
// return (
//   <>
//     <h1>List a Hackathon</h1>
//   <form>
//       <h2>Organizer Information</h2>
//       <label htmlFor="organiser_name">Organiser Name:</label>
//       <input type="text" id="organiser_name" name="organiser_name" required/>
//       <label htmlFor="organiser_details">Organiser Details:</label>
//       <textarea id="organiser_details" name="organiser_details" rows="5"></textarea>
//       <label htmlFor="organiser_email">Organiser Email:</label>
//       <input type="email" id="organiser_email" name="organiser_email" required/>

//       <h2>Hackathon Details</h2>
//       <label htmlFor="hackathon_name">Hackathon Name:</label>
//       <input type="text" id="hackathon_name" name="hackathon_name" required/>
//       <label htmlFor="hackathon_description">Hackathon Description:</label>
//       <textarea id="hackathon_description" name="hackathon_description" rows="10"></textarea>
//       <label htmlFor="registration_start">Registration Start:</label>
//       <input type="datetime-local" id="registration_start" name="registration_start" required/>
//       <label htmlFor="registration_end">Registration End:</label>
//       <input type="datetime-local" id="registration_end" name="registration_end" required/>
//       <label htmlFor="hackathon_start">Hackathon Start:</label>
//       <input type="datetime-local" id="hackathon_start" name="hackathon_start" required/>
//       <label htmlFor="hackathon_end">Hackathon End:</label>
//       <input type="datetime-local" id="hackathon_end" name="hackathon_end" required/>
//       <label htmlFor="pool_prize">Pool Prize:</label>
//       <input type="number" id="pool_prize" name="pool_prize" min="0" required/>

//       <input type="submit" className="submit-button" value="List Hackathon"/>
//   </form>
//   </>
// )
