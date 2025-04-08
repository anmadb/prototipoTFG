import './App.css'

import { BrowserRouter, Routes, Route } from "react-router";

import Home from './pages/home.jsx'
import CreatePost from './pages/CreatePost.jsx'
import Login_SingUp from './pages/Login_SingUp.jsx';


function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/createPost" element={<CreatePost />} />
        <Route path="/login" element={<Login_SingUp />} />
      </Routes>
    </BrowserRouter>

  )
}

export default App
