import Navbar from "../components/navbar/Navbar";
import { useState } from "react";
import './CreatePost.css'

export default function CreatePost() {
    const [preview, setPreview] = useState(null);

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onloadend = () => {
                setPreview(reader.result);
            };
            reader.readAsDataURL(file);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        try {
            const formData = new FormData();
            const imageFile = document.getElementById('imagen').files[0];
            
            if (!imageFile) {
                throw new Error("Debes seleccionar una imagen");
            }
    
            formData.append('image', imageFile);
            formData.append('description', document.getElementById('descripcion').value);
            formData.append('latitude', document.getElementById('latitud').value);
            formData.append('longitude', document.getElementById('longitud').value);
    
            // Verificación en consola
            console.log("Datos a enviar:");
            for (let [key, value] of formData.entries()) {
                console.log(key, value);
            }
    
            const response = await fetch(`${import.meta.env.VITE_BACKEND_URL}/api/posts`, {
                method: 'POST',
                body: formData
                // NO incluyas el header Content-Type! Deja que el navegador lo establezca automáticamente
            });
    
            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Error ${response.status}: ${errorText}`);
            }
    
          
            window.location.href = '/home'; // Redirigir a la página de inicio después de crear el post
    
        } catch (error) {
            console.error('Error al enviar el formulario:', error);
            alert('Error: ' + error.message);
        }
    };

    return (
        <>
            <Navbar/>
            <main className="content-w-navbar">
                <h1>Create Post</h1>
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="imagen">Imagen:</label>
                        <input
                            type="file"
                            id="imagen"
                            name="imagen"
                            accept="image/*"
                            onChange={handleImageChange}
                            required
                        />
                        {preview && (
                            <div className="image-preview">
                                <img src={preview} alt="Vista previa" style={{ maxWidth: '200px', maxHeight: '200px' }} />
                            </div>
                        )}
                    </div>

                    <div className="form-group">
                        <label htmlFor="descripcion">Descripción:</label>
                        <textarea
                            id="descripcion"
                            name="descripcion"
                            required
                            rows="4"
                        />
                    </div>

                    <div className="form-group">
                        <label htmlFor="latitud">Latitud:</label>
                        <input
                            type="number"
                            id="latitud"
                            name="latitud"
                            required
                            step="any"
                            placeholder="Ej: 40.7128"
                        />
                    </div>

                    <div className="form-group">
                        <label htmlFor="longitud">Longitud:</label>
                        <input
                            type="number"
                            id="longitud"
                            name="longitud"                          
                            required
                            step="any"
                            placeholder="Ej: -74.0060"
                        />
                    </div>

                    <button type="submit" className="submit-btn">Enviar</button>
                </form>
            </main>
        </>
    );
}