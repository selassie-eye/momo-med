// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');
const request = require('request');
const search = require('./foursquare-api.js').search;

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
var _v = '20180816';

var t_radius = 50;
var t_ll = '29.6478,-82.33784';
var t_query = 'hospital';
admin.initializeApp();

exports.searchRequest = functions.https.onRequest((req, res) => {
    const clientQuery = req.query.search;
    const clientLL = req.query.ll;
    console.log(clientLL);

    search(t_radius, clientLL, _v, clientQuery, (body) => {
        return res.send(body);
    });
});
