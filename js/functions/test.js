const search = require('./foursquare-api.js').search;

var t_radius = 50;
var t_ll = '29.6478,-82.33784';
var t_v = '20180816';
var t_query = 'hospital';

search(t_radius, t_ll, t_v, t_query, (body) => { console.dir(body[0]['venue']['location']); });