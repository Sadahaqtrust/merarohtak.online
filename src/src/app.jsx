import React, { useState } from "react";
import "./index.css";

function App() {
  const [lang, setLang] = useState("hi");

  const text = {
    hi: {
      title: "साडा हक़ परिवार का सदस्य बनें",
      subtitle: "शहर, सेवा और युवाओं के लिए डिजिटल प्रयास।",
      phoneEmail: "मोबाइल / ईमेल",
      password: "पासवर्ड",
      confirmPassword: "कन्फर्म पासवर्ड",
      signup: "साडा हक़ परिवार का सदस्य बनें",
      loginLink: "पहले से सदस्य हैं? लॉगिन करें",
    },
    en: {
      title: "Become a Sadahaq Family Member",
      subtitle: "Digital effort for youth, city and service.",
      phoneEmail: "Phone / Email",
      password: "Password",
      confirmPassword: "Confirm Password",
      signup: "Join Sadahaq Family",
      loginLink: "Already a member? Login",
    },
  };

  return (
    <div className="mr-container">
      {/* ---- TOP NAV ---- */}
      <div className="mr-topbar">
        <div className="mr-logo">मेरा रोहतक ऑनलाइन</div>

        <div className="mr-lang-container">
          <button
            className={`mr-lang-btn ${lang === "hi" ? "mr-lang-active" : ""}`}
            onClick={() => setLang("hi")}
          >
            हिन्दी
          </button>
          <button
            className={`mr-lang-btn ${lang === "en" ? "mr-lang-active" : ""}`}
            onClick={() => setLang("en")}
          >
            English
          </button>
        </div>
      </div>

      {/* ---- CARD ---- */}
      <div className="mr-card">
        <h2 className="mr-title">{text[lang].title}</h2>
        <p className="mr-sub">{text[lang].subtitle}</p>

        <input className="mr-input" placeholder={text[lang].phoneEmail} />
        <input className="mr-input" type="password" placeholder={text[lang].password} />
        <input className="mr-input" type="password" placeholder={text[lang].confirmPassword} />

        <div className="mr-actions">
          <button className="mr-btn primary">{text[lang].signup}</button>
          <button className="mr-btn secondary">{text[lang].loginLink}</button>
        </div>
      </div>

      <footer className="mr-footer">© 2025 Mera Rohtak — Youth + City + Seva</footer>
    </div>
  );
}

export default App;
