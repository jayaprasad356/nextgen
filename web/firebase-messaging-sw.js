importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
  apiKey: "AIzaSyCuvfJETE0AdzyfYZ6IpzW1T4J2pAFE6JY",
  authDomain: "next-gen-a052d.firebaseapp.com",
  projectId: "next-gen-a052d",
  storageBucket: "next-gen-a052d.appspot.com",
  messagingSenderId: "526593393536",
  appId: "1:526593393536:web:56701da3c74f04288cb765",
  measurementId: "G-ZZRN46NH58"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});