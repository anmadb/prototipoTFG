import { useEffect } from 'react';
import './Navbar.css'

export default function Navbar() {

    useEffect(() => {
        const url = window.location.href;
        const navbar = document.getElementById('navbar');

        if (url == 'http://localhost:5173/') {
            navbar.classList.add('startAnimNavbar');
        }
    })


    return (
        <nav id='navbar' className='navbar'>
            <a className='btn' href="/home">Home</a>
            <a className='btn' href="/createPost">Create New Post</a>
            <a className='btn' href="/login">Log Out</a>
        </nav>
    )
}