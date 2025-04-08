import './Navbar.css'

export default function Navbar() {
    return (
        <nav className='navbar'>
            <a className='btn' href="/">Home</a>
            <a className='btn' href="/createPost">Create New Post</a>
            <a className='btn' href="/login">Log Out</a>
        </nav>
    )
}