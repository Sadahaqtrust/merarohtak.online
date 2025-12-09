// src/App.jsx
import { useState } from "react";
import "./index.css";

const API_BASE = "http://localhost:5000";

// --- Translations ---
const translations = {
  hi: {
    appTitle: "मेरा रोहतक ऑनलाइन",
    subtitle: "शहर, सेवा और युवाओं के लिए डिजिटल प्रयास।",
    headingSignup: "साड़ा हक़ परिवार का सदस्य बनें",
    headingLogin: "पहले से साड़ा हक़ परिवार के सदस्य हैं? लॉगिन करें",
    mobileEmail: "मोबाइल / ईमेल",
    password: "पासवर्ड",
    confirmPassword: "कन्फ़र्म पासवर्ड",
    signupCta: "साड़ा हक़ परिवार का सदस्य बनें",
    alreadyMember: "पहले से साड़ा हक़ परिवार के सदस्य हैं? लॉगिन करें",
    notMemberYet: "नए हैं? सदस्य बनें",
    loginCta: "लॉगिन करें",
    logout: "लॉगआउट",
    hindi: "हिन्दी",
    english: "English",
    loggedInAs: "आप लॉगिन हैं:",
    errorPrefix: "त्रुटि:",
    successPrefix: "सफलता:",

    // messages
    msgFillAllFields: "कृपया सभी फ़ील्ड भरें।",
    msgPasswordMismatch: "पासवर्ड और कन्फ़र्म पासवर्ड समान नहीं हैं।",
    msgSignupSuccess: "साइनअप सफल। कृपया लॉगिन करें।",
    msgLoginSuccess: "लॉगिन सफल।",
    msgSignupFailed: "साइनअप असफल रहा।",
    msgLoginFailed: "लॉगिन असफल रहा।",
    msgServerErrorSignup: "साइनअप के दौरान सर्वर त्रुटि।",
    msgServerErrorLogin: "लॉगिन के दौरान सर्वर त्रुटि।",
    msgUserExists: "यह मोबाइल/ईमेल पहले से रजिस्टर्ड है। कृपया लॉगिन करें।"
  },
  en: {
    appTitle: "Mera Rohtak Online",
    subtitle: "A digital initiative for youth, city and seva.",
    headingSignup: "Become a SadaHaq family member",
    headingLogin: "Already a SadaHaq family member? Log in",
    mobileEmail: "Mobile / Email",
    password: "Password",
    confirmPassword: "Confirm Password",
    signupCta: "Become a SadaHaq family member",
    alreadyMember: "Already a SadaHaq family member? Log in",
    notMemberYet: "New here? Become a member",
    loginCta: "Log in",
    logout: "Log out",
    hindi: "हिन्दी",
    english: "English",
    loggedInAs: "You are logged in as:",
    errorPrefix: "Error:",
    successPrefix: "Success:",

    // messages
    msgFillAllFields: "Please fill all fields.",
    msgPasswordMismatch: "Passwords do not match.",
    msgSignupSuccess: "Signup successful. Please log in.",
    msgLoginSuccess: "Login successful.",
    msgSignupFailed: "Signup failed.",
    msgLoginFailed: "Login failed.",
    msgServerErrorSignup: "Server error during signup.",
    msgServerErrorLogin: "Server error during login.",
    msgUserExists: "Account already exists. Please log in."
  }
};

export default function App() {
  const [lang, setLang] = useState("hi");
  const [view, setView] = useState("signup"); // signup | login | profile
  const [identifier, setIdentifier] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [message, setMessage] = useState("");
  const [messageType, setMessageType] = useState(""); // 'error' | 'success'
  const [loading, setLoading] = useState(false);
  const [user, setUser] = useState(null); // { userId, email, phone }

  const t = (key) => translations[lang][key];

  const resetMessages = () => {
    setMessage("");
    setMessageType("");
  };

  const resetForm = () => {
    setIdentifier("");
    setPassword("");
    setConfirmPassword("");
  };

  // --- API calls ---

  async function handleSignup(e) {
    e.preventDefault();
    resetMessages();

    if (!identifier || !password || !confirmPassword) {
      setMessageType("error");
      setMessage(t("msgFillAllFields"));
      return;
    }
    if (password !== confirmPassword) {
      setMessageType("error");
      setMessage(t("msgPasswordMismatch"));
      return;
    }

    setLoading(true);
    try {
      const res = await fetch(`${API_BASE}/api/auth/signup`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ identifier, password })
      });

      const data = await res.json();

      // User already exists → do NOT create, move to login
      if (res.status === 409 && data.error === "USER_EXISTS") {
        setMessageType("error");
        setMessage(t("msgUserExists"));
        // keep identifier so user can directly login
        setPassword("");
        setConfirmPassword("");
        setView("login");
        return;
      }

      if (!res.ok) {
        setMessageType("error");
        setMessage(data.error || t("msgSignupFailed"));
      } else {
        setMessageType("success");
        setMessage(t("msgSignupSuccess"));
        resetForm();
        setView("login");
      }
    } catch (err) {
      console.error(err);
      setMessageType("error");
      setMessage(t("msgServerErrorSignup"));
    } finally {
      setLoading(false);
    }
  }

  async function handleLogin(e) {
    e.preventDefault();
    resetMessages();

    if (!identifier || !password) {
      setMessageType("error");
      setMessage(t("msgFillAllFields"));
      return;
    }

    setLoading(true);
    try {
      const res = await fetch(`${API_BASE}/api/auth/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ identifier, password })
      });

      const data = await res.json();

      if (!res.ok) {
        setMessageType("error");
        setMessage(data.error || t("msgLoginFailed"));
      } else {
        setMessageType("success");
        setMessage(t("msgLoginSuccess"));
        setUser({
          userId: data.userId,
          email: data.email,
          phone: data.phone
        });
        resetForm();
        setView("profile");
      }
    } catch (err) {
      console.error(err);
      setMessageType("error");
      setMessage(t("msgServerErrorLogin"));
    } finally {
      setLoading(false);
    }
  }

  function handleLogout() {
    setUser(null);
    resetMessages();
    setView("login");
  }

  // --- Render helpers ---

  const renderMessage = () => {
    if (!message) return null;
    const prefix =
      messageType === "error"
        ? translations[lang].errorPrefix
        : translations[lang].successPrefix;
    return (
      <div className={`mr-alert mr-alert-${messageType}`}>
        <strong>{prefix}</strong> {message}
      </div>
    );
  };

  const renderSignupForm = () => (
    <form onSubmit={handleSignup}>
      <h1 className="mr-heading">{t("headingSignup")}</h1>
      <p className="mr-subtitle">{t("subtitle")}</p>

      <label className="mr-label">
        {t("mobileEmail")}
        <input
          className="mr-input"
          value={identifier}
          onChange={(e) => setIdentifier(e.target.value)}
        />
      </label>

      <label className="mr-label">
        {t("password")}
        <input
          className="mr-input"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </label>

      <label className="mr-label">
        {t("confirmPassword")}
        <input
          className="mr-input"
          type="password"
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
        />
      </label>

      {renderMessage()}

      <div className="mr-btn-row">
        <button
          type="submit"
          className="mr-btn mr-btn-primary"
          disabled={loading}
        >
          {loading ? "..." : t("signupCta")}
        </button>

        {/* Once user has chosen Signup path → hide other path while processing */}
        {!loading && (
          <button
            type="button"
            className="mr-btn mr-btn-secondary"
            onClick={() => {
              resetMessages();
              resetForm();
              setView("login");
            }}
          >
            {t("alreadyMember")}
          </button>
        )}
      </div>
    </form>
  );

  const renderLoginForm = () => (
    <form onSubmit={handleLogin}>
      <h1 className="mr-heading">{t("headingLogin")}</h1>
      <p className="mr-subtitle">{t("subtitle")}</p>

      <label className="mr-label">
        {t("mobileEmail")}
        <input
          className="mr-input"
          value={identifier}
          onChange={(e) => setIdentifier(e.target.value)}
        />
      </label>

      <label className="mr-label">
        {t("password")}
        <input
          className="mr-input"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </label>

      {renderMessage()}

      <div className="mr-btn-row">
        <button
          type="submit"
          className="mr-btn mr-btn-secondary"
          disabled={loading}
        >
          {loading ? "..." : t("loginCta")}
        </button>

        {/* Once user has chosen Login path → hide other path while processing */}
        {!loading && (
          <button
            type="button"
            className="mr-btn mr-btn-primary"
            onClick={() => {
              resetMessages();
              resetForm();
              setView("signup");
            }}
          >
            {t("notMemberYet")}
          </button>
        )}
      </div>
    </form>
  );

  const renderProfile = () => (
    <div>
      <h1 className="mr-heading">{t("headingSignup")}</h1>
      <p className="mr-subtitle">
        {t("loggedInAs")}{" "}
        <strong>{user?.email || user?.phone || user?.userId}</strong>
      </p>

      {renderMessage()}

      <div className="mr-btn-row">
        <button
          type="button"
          className="mr-btn mr-btn-secondary"
          onClick={handleLogout}
        >
          {t("logout")}
        </button>
      </div>
    </div>
  );

  return (
    <div className="mr-app">
      {/* Top Bar */}
      <header className="mr-topbar">
        <div className="mr-topbar-title">{t("appTitle")}</div>
        <div className="lang-toggle">
          <button
            className={`lang-btn ${
              lang === "hi" ? "active" : "inactive"
            }`}
            onClick={() => setLang("hi")}
            type="button"
          >
            {t("hindi")}
          </button>
          <button
            className={`lang-btn ${
              lang === "en" ? "active" : "inactive"
            }`}
            onClick={() => setLang("en")}
            type="button"
          >
            {t("english")}
          </button>
        </div>
      </header>

      {/* Main Card */}
      <main className="mr-main">
        <div className="mr-card">
          {view === "signup" && renderSignupForm()}
          {view === "login" && renderLoginForm()}
          {view === "profile" && renderProfile()}
        </div>
      </main>

      <footer className="mr-footer">
        © 2025 Mera Rohtak – Youth + City + Seva
      </footer>
    </div>
  );
}
