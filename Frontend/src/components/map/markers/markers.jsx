import 'leaflet/dist/leaflet.css'
import {Marker, Popup} from 'react-leaflet'
import { Icon } from 'leaflet';
import { useState, useEffect } from 'react';

import './style.css'

export default function Markers() {

  // * Get Posts data
  const [posts, setPosts] = useState(null)
  useEffect(() => {
      fetch('http://localhost:8080/api/posts')
        .then(res => {return res.json()})
        .then(data => {
          console.log(data)
          setPosts(data)
        })
  }, [])

  // * Custom Icon
  const customIcon = new Icon({
    iconUrl: "https://cdn-icons-png.flaticon.com/128/447/447031.png",
    iconSize: [30,30],
    iconAnchor: [15, 30]
  })

  function deletePost(id) {
   
    fetch(`http://localhost:8080/api/posts/${id}`, {
      method: 'DELETE',
      
    })
      window.location.reload()
    
  }

  return (

    
    <>
      {posts && posts.map(post => (
        // eslint-disable-next-line react/jsx-key
        <Marker position={[post.latitude, post.longitude]} icon={customIcon}>
          <Popup className='popup'
            minWidth={200}  
            maxWidth={600}  
            closeButton={false} >
            {post.img && (
              <img className='imgPost' src={`http://localhost:8080/api/posts/img/${post.img}`} />
            )}
            <p>{post.description}</p>
            
            <button onClick={(e) => {e.preventDefault; deletePost(post.id)}}>Delete</button>
            
          </Popup>
        </Marker>
      ))}
    </>
  )
}