import React from "react";
import { useNavigate } from "react-router-dom";
import Navbar from "../navbar/Navbar.jsx";
import Sidebar from "../sidebar/Sidebar.jsx";
import "../navbar/Navbar.css";
import "../sidebar/Sidebar.css";
import "./Privacy.css";

export default function Privacy() {
  const navigate = useNavigate();

  const handleSaveClick = () => {
    // Aquí iría la lógica de guardado futuro
    navigate("/home");
  };

  return (
    <div className="privacy-page">
      <Sidebar />
      <div className="privacy-section">
        
        <h1 className="privacy-title">Configuración de Privacidad</h1>
        <div className="privacy-card">

          <div className="privacy-option">
            <label>¿Quién puede ver tu perfil?</label>
            <select>
              <option>Público</option>
              <option>Solo amigos</option>
              <option>Privado</option>
            </select>
          </div>

          <div className="privacy-option">
            <label>¿Quién puede comentar en tus publicaciones?</label>
            <select>
              <option>Todos</option>
              <option>Solo seguidores</option>
              <option>Nadie</option>
            </select>
          </div>

          <div className="privacy-option">
            <label>Solicitudes de seguimiento</label>
            <select>
              <option>Aceptación manual</option>
              <option>Aceptar automáticamente</option>
            </select>
          </div>

        <button className="save-btn" onClick={handleSaveClick}>
          Guardar configuración
        </button>
          

        </div>

        <div className="privacy-option danger">
            <button>Eliminar cuenta</button>
          </div>
        
      </div>
    </div>
  );
}
