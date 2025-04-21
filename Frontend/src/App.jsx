import './App.css'

import { BrowserRouter, Routes, Route } from "react-router-dom";

import Home from './pages/home.jsx'
import CreatePost from './pages/CreatePost.jsx'
import SingUp from './pages/SingUp.jsx';
import Login from './pages/Login.jsx';


function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/h" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/createPost" element={<CreatePost />} />
        <Route path="/SingUp" element={<SingUp />} />
        <Route path="/" element={<Login />} />
      </Routes>
    </BrowserRouter>

  )
}

export default App
