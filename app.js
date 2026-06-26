const express = require('express');
const dotenv = require('dotenv');

const env = process.argv[2] || "development";
dotenv.config({ path: `.env.${env}` });

const app = express();

function log(message) {
    const time = new Date().toISOString();
    console.log(`[${time}] [${env.toUpperCase()}] ${message}`);
}

// ✅ Set default port if not provided
const PORT = process.env.PORT || 3000;
const APP = process.env.APP || "MyApp";

app.get('/', (req, res) => {
    res.send('Hello World from ' + APP);
});

app.get('/health', (req, res) => {
    log("Health check been called");
    res.status(200).json({
        status: "UP"
    });
});

app.listen(PORT, '0.0.0.0', () => {
    log("Server is running on port " + PORT);
});

