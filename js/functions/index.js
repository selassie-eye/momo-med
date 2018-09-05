// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');
const request = require('request');
const search = require('./foursquare-api').search;
const categories = require('./foursquare-api').categories

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');

var _placesAPIKey = 'AIzaSyDWR6zUgE9BfMQU-u_p21yJqXlp5CbbBfA';

var _clientID = '1MV24XBQKT1231E3PZPXOLKS32AX3DQLEZP21D1R0TYTL1I0';
var _clientSecret = 'GA1Z3CUGDTBPYTBIP4DHDUR1LXTPJX3TKRELITHF43OGHNMP';
var _v = '20180816';

var t_radius = 50;
var t_ll = '29.6478,-82.33784';
var t_query = 'hospital';
admin.initializeApp();

exports.searchRequest = functions.https.onRequest((req, res) => {
    console.log(req.originalUrl);
    const clientQuery = req.originalUrl.split('?')[1];
    const header = `&key=${_placesAPIKey}`;
    const apiRequest = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?' + clientQuery + header;
    console.log(apiRequest);

    search(apiRequest, (body) => {
        return res.send(body);
    });
});

exports.getCategories = functions.https.onRequest((req, res) => {
    categories((body) => { return res.send(body); });
});
