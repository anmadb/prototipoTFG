export default function CreatePost() {
    return (
        <div>
            <nav style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', margin: '20px', width: '100%'}}>
                <button onClick={() => {window.location.href = '/'}}>Home</button>
                <button onClick={() => {window.location.href = '/createPost'}}>Create New Post</button>
                <button onClick={() => {window.location.href = '/login'}}>Log Out</button>
            </nav>
            <h1>Create Post</h1>
            
        </div>
    );
}