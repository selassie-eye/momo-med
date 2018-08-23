const search = require('./foursquare-api').search;
const categories = require('./foursquare-api').categories;

var t_radius = 50;
var t_ll = '29.6478,-82.33784';
var t_v = '20180816';
var t_query = 'hospital';

//  search('https://api.foursquare.com/v2/venues/search?client_id=1MV24XBQKT1231E3PZPXOLKS32AX3DQLEZP21D1R0TYTL1I0&client_secret=GA1Z3CUGDTBPYTBIP4DHDUR1LXTPJX3TKRELITHF43OGHNMP&v=20180816&ll=29.6478,-82.33784&radius=1000&query=hospital', (body) => { console.dir(body); });
categories((body) => { console.dir(body); });