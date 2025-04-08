import Map from "../components/map/map";

export default function Home() {
    return (
        <>
        <Map
        position={null}
        zoom={null}
        scroll={null}
        />
        <nav style={{display: 'inline-flex', flexDirection: 'column', justifyContent: 'center', height: '100vh', width: '150px', gap: '10px', boxSizing: 'border-box', padding: '10px'}}>
        <button onClick={() => {window.location.href = '/'}}>Home</button>
        <button onClick={() => {window.location.href = '/createPost'}}>Create New Post</button>
        <button onClick={() => {window.location.href = '/login'}}>Log Out</button>
        </nav>
        </>
    )
}