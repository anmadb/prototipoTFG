// src/components/pages/Home.jsx
import React from "react";
import Sidebar from "../sidebar/Sidebar";
import Topbar from "../topbar/Topbar";
import Map from "../map/Map";
import "../styles/Home.css";


const Home = () => {
  return (
    <div className="home-container">
      <Sidebar />
      <div className="main-content">
        <Topbar />
        <div className="map-wrapper">
          <Map position={null} zoom={null} scroll={null} />
        </div>
      </div>
    </div>
  );
};

export default Home;
