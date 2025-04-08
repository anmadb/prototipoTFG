import Map from "../components/map/map";
import Navbar from "../components/navbar/Navbar";

export default function Home() {
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