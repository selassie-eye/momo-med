const search = require('./foursquare-api').search;
const categories = require('./foursquare-api').categories;

var t_radius = 50;
var t_ll = '29.6478,-82.33784';
var t_v = '20180816';
var t_query = 'hospital';
var _placesAPIKey = 'AIzaSyDjKHhAPv2GRaMQ8ZTyNIkEZk4eh66B_7U';
var _types = 'dentist,'


//  search('https://api.foursquare.com/v2/venues/search?client_id=1MV24XBQKT1231E3PZPXOLKS32AX3DQLEZP21D1R0TYTL1I0&client_secret=GA1Z3CUGDTBPYTBIP4DHDUR1LXTPJX3TKRELITHF43OGHNMP&v=20180816&ll=29.6478,-82.33784&radius=100000&query=shands', (body) => { console.dir(body); });
search(`https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${t_ll}&rankby=distance&type=doctor&keyword=hospital&key=${_placesAPIKey}`, (body) => { console.dir(body); });