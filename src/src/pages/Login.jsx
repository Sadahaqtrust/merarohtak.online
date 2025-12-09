import { useState } from "react";

function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  const API_URL = "http://localhost:5000/api/login";

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");
    setMessage("");

    try {
      const response = await fetch(API_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username, password }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || "Invalid credentials");
        return;
      }

      setMessage("Login successful ✅");
      console.log("User logged in:", data.user);

      localStorage.setItem("user", JSON.stringify(data.user));

    } catch (err) {
      setError("Network error: " + err.message);
    }
  };

  return (
    <div style={{ maxWidth: "400px", margin: "50px auto", padding: "20px", border: "1px solid #ccc", borderRadius: "6px" }}>
      <h2>Login</h2>

      <form onSubmit={handleLogin}>
        <label>Username</label>
        <input 
          type="text" 
          value={username} 
          onChange={(e) => setUsername(e.target.value)} 
          style={{ width: "100%", padding: "8px", marginBottom: "10px" }} 
        />

        <label>Password</label>
        <input 
          type="password" 
          value={password} 
          onChange={(e) => setPassword(e.target.value)} 
          style={{ width: "100%", padding: "8px", marginBottom: "10px" }} 
        />

        <button type="submit" style={{ width: "100%", padding: "10px" }}>
          Login
        </button>
      </form>

      {error && <p style={{ color: "red" }}>{error}</p>}
      {message && <p style={{ color: "green" }}>{message}</p>}
    </div>
  );
}

export default Login;
