import Map from "../components/map/map";
import Navbar from "../components/navbar/Navbar";

export default function Home() {

    if (window.performance.navigation.type === 1 && window.location.pathname === '/') {
        window.location.pathname = '/home';
    }

    return (
        <>
        <Navbar/>
            <main className="content-w-navbar">
            <Map
            position={null}
            zoom={null}
            scroll={null}
            />
            </main>
        </>
    )
}