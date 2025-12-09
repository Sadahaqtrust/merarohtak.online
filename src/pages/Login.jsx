import { useState, useEffect } from "react";

export default function Login() {
  const [form, setForm] = useState({ email: "", password: "" });

  useEffect(() => {
    console.log("✅ Login component mounted");
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log("🚀 Login form submitted", form);

    try {
      const res = await fetch("http://localhost:5000/api/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });

      const data = await res.json();
      console.log("📥 API response:", data);

      if (!res.ok) {
        alert(data.message || "Login failed");
        return;
      }

      alert("Login success");
      // TODO: redirect to dashboard
    } catch (err) {
      console.error("❌ Login error:", err);
      alert("Server error");
    }
  };

console.log("MR Login rendered");

  return (
    <div className="login-page">
      <h1>Login</h1>

      {/* IMPORTANT: onSubmit on <form> and button type="submit" */}
      <form onSubmit={handleSubmit}>
        <div>
          <label>
            Email
            <input
              name="email"
              type="email"
              value={form.email}
              onChange={handleChange}
            />
          </label>
        </div>

        <div>
          <label>
            Password
            <input
              name="password"
              type="password"
              value={form.password}
              onChange={handleChange}
            />
          </label>
        </div>

        <button type="submit">Login</button>
      </form onSubmit={handleSubmit}>
    </div>
  );
}
