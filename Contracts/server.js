// Connecting Express library
const express = require('express');
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');
const dotenv = require('dotenv').config();
// Connection of the module: server paths
const pages = require('./routers/authRouters'); //page
const controller = require('./controller/auth'); //logic

// Resolving the issue with files requiring AbortController (in node.js v16.x.x., this issue is resolved)
const {AbortController} = require('node-abort-controller');
global.AbortController = AbortController;
/******************* */
// The port is either the standard one or 3000 if not specified
const PORT = process.env.PORT || 3000;

// Using Express
const app = express();
app.use(express.json());

// Static files
app.use("/css",express.static(__dirname + "/public/css"));
app.use("/js",express.static(__dirname + "/public/js"));
app.use("/utils",express.static(__dirname + "/public/utils"));
app.use("/image",express.static(__dirname + "/public/image"));

app.engine('ejs', require('ejs-mate'));
app.set("view engine" , 'ejs');
app.set("views","./views");
app.use(bodyParser.urlencoded({extended: true}));
app.use(fileUpload());

// Separation of logic and frontend
app.use('/', pages); // when using the paths module, specify / first and then the name #/login
app.use("/api", controller); // for server interaction TODO: interaction with web3Provider

// Start of the server
const startServer = async function()
{
    try 
    {
        app.listen(PORT, () => console.log(`Server start on the port ${PORT}`));
    } catch (error) 
    {
        console.log(error);   
        console.error('Unable to connect to the server:', error); 
    }
}

startServer();