import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { getCookie, checkIsLogged } from "../../scripts/logged.js";
import Sidebar from "../sidebar/Sidebar.jsx";
import "../sidebar/Sidebar.css";
import "./Profile.css";
import FriendButton from "../friendButton/FriendButton.jsx";

export default function Profile() {
    const { username } = useParams(); // Obtener username de la URL
    const navigate = useNavigate(); // Para redireccionar
    const [isLogged, setIsLogged] = useState(null);
    const [currentUserId, setCurrentUserId] = useState(null);
    const [currentUsername, setCurrentUsername] = useState(null);
    const [profile, setProfile] = useState(null);
    const [posts, setPosts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isOwnProfile, setIsOwnProfile] = useState(false);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = getCookie('isLogged');
                const loginResponse = await checkIsLogged(token);
                const loginData = await loginResponse.json();
                
                if (loginData.res === "false") {
                    window.location.href = "/";
                    return;
                }
                
                setCurrentUserId(loginData.id);
                setIsLogged(true);
                
                // Obtener el username del usuario actual
                const currentUserResponse = await fetch(`http://localhost:8080/api/profile/${loginData.id}`);
                if (!currentUserResponse.ok) throw new Error('Failed to fetch current user data');
                const currentUserData = await currentUserResponse.json();
                setCurrentUsername(currentUserData.username);
                
                let profileUserId;
                
                // Si hay username en la URL, verificar si es el propio usuario
                if (username) {
                    // Si el username de la URL es igual al del usuario actual, redirigir a /profile
                    if (username === currentUserData.username) {
                        navigate('/profile', { replace: true });
                        return;
                    }
                    
                    const userResponse = await fetch(`http://localhost:8080/api/profile/username/${username}`);
                    if (!userResponse.ok) {
                        throw new Error('Usuario no encontrado');
                    }
                    const userData = await userResponse.json();
                    profileUserId = userData.id;
                    
                    // Verificar si es el perfil propio (doble verificación)
                    setIsOwnProfile(loginData.id === userData.id);
                } else {
                    // Si no hay username, mostrar perfil propio
                    profileUserId = loginData.id;
                    setIsOwnProfile(true);
                }
                
                // Fetch profile data
                const profileResponse = await fetch(`http://localhost:8080/api/profile/${profileUserId}`);
                if (!profileResponse.ok) throw new Error('Failed to fetch profile');
                const profileData = await profileResponse.json();
                setProfile(profileData);
                
                // Fetch user posts
                const postsResponse = await fetch(`http://localhost:8080/api/posts/user/${profileUserId}`);
                if (!postsResponse.ok) throw new Error('Failed to fetch posts');
                const postsData = await postsResponse.json();
                setPosts(postsData || []);
                
            } catch (err) {
                console.error("Error fetching data:", err);
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };
        
        fetchData();
    }, [username, navigate]); // Dependencias en username y navigate

    const deletePost = async (id) => {
        if (!isOwnProfile) return; // Solo permitir eliminar en perfil propio
        
        try {
            const response = await fetch(`http://localhost:8080/api/posts/${id}`, {
                method: 'DELETE',
            });
            
            if (!response.ok) throw new Error('Failed to delete post');
            
            // Optimistic update - remove the post from state instead of reloading
            setPosts(prevPosts => prevPosts.filter(post => post.id !== id));
            
        } catch (err) {
            console.error("Error deleting post:", err);
            alert("No se pudo eliminar la publicación. Inténtalo de nuevo.");
        }
    };

    if (!isLogged) {
        return (
            <>
                <Sidebar/>
                <main className="content-w-navbar">
                    <h1 className="loading">Loading...</h1>
                </main>
            </>
        );
    }

    if (loading) {
        return (
            <>
                <Sidebar/>
                <main className="content-w-navbar">
                    <h1 className="loading">Loading profile data...</h1>
                </main>
            </>
        );
    }

    if (error) {
        return (
            <>
                <Sidebar/>
                <main className="content-w-navbar">
                    <h1 className="error">Error: {error}</h1>
                </main>
            </>
        );
    }

    return (
        <>
            <Sidebar/>
            <main className="content-w-navbar">
                {profile && (
                    <>
                        <div className="profile-container">
                            <div className="profile-header">
                                <h1 className="profile-title">
                                    {profile.username}
                                    {isOwnProfile && <span className="own-profile-indicator"> (Tu perfil)</span>}
                                </h1>
                                
                                <img 
                                    className="profile-avatar" 
                                    src={`http://localhost:8080/api/profile/img/${profile.avatar}`} 
                                    alt={`Avatar de ${profile.username}`} 
                                    width="400px"
                                    onError={(e) => {
                                        e.target.onerror = null; 
                                        e.target.src = '/default-avatar.png';
                                    }}
                                />
                                
                            </div>
                            {!isOwnProfile && <FriendButton targetUserId={profile.id} targetUsername={profile.username} />}
                            <div className="profile-info">
                                <div className="profile-field">
                                    <span className="profile-label">Biografía</span>
                                    <span className="profile-value">{profile.bio || "No hay biografía disponible"}</span>
                                </div>
                                <div className="profile-field">
                                    <span className="profile-label">Miembro desde</span>
                                    <span className="profile-value">
                                        {new Date(profile.createdAt).toLocaleDateString()}
                                    </span>
                                </div>                
                            </div>
                        </div>
                        
                        <div className="posts-section">
                            <h1 className="posts-title">
                                {isOwnProfile ? "Mis Publicaciones" : `Publicaciones de ${profile.username}`}
                            </h1>
                            <div className="posts-grid">
                                {posts.length > 0 ? (
                                    posts.map(post => (
                                        <div className="post-card" key={post.id}>
                                            <h3 className="post-author">
                                                @{isOwnProfile ? "You" : profile.username}
                                            </h3>
                                            <img 
                                                src={`http://localhost:8080/api/posts/img/${post.img}`} 
                                                alt="Post" 
                                                className="post-image"
                                                onError={(e) => {
                                                    e.target.onerror = null; 
                                                    e.target.src = '/default-post.png';
                                                }}
                                            />
                                            <p className="post-description">{post.description}</p>
                                            {isOwnProfile && (
                                                <button 
                                                    className="delete-btn" 
                                                    onClick={() => deletePost(post.id)}
                                                >
                                                    Delete
                                                </button>
                                            )}
                                        </div>
                                    ))
                                ) : (
                                    <p>
                                        {isOwnProfile 
                                            ? "No hay publicaciones aún" 
                                            : `${profile.username} no tiene publicaciones aún`
                                        }
                                    </p>
                                )}
                            </div>
                        </div>
                    </>
                )}
            </main>
        </>
    );
}