var fetchUrl = require('fetch').fetchUrl;

const searchBaseURL = 'https://api.foursquare.com/v2/venues/search';
const catBaseURL = 'https://api.foursquare.com/v2/venues/categories';

var clientID = '1MV24XBQKT1231E3PZPXOLKS32AX3DQLEZP21D1R0TYTL1I0';
var clientSecret = 'GA1Z3CUGDTBPYTBIP4DHDUR1LXTPJX3TKRELITHF43OGHNMP';
var category = '4bf58dd8d48988d104941735';
var ver = '20180816';

function _catGetBuilder() { 
    return catBaseURL + '?' + 
    `client_id=${clientID}` + '&' +
    `client_secret=${clientSecret}` + '&' +
    `v=${ver}` + '&' +
    `id=${category}`; 
}

function _queryBuilder(radius, ll, v, query) {
    return searchBaseURL + 
        `?client_id=${clientID}` +
        `&client_secret=${clientSecret}` +
        `&v=${v}` +
        `&ll=${ll}` +
        `&radius=50000` +
        `&intent=browse` +
        `&query=${query}` +
        `&categoryId=${category}`;
}

var getHealthCategories = (callback) => { fetchUrl(_catGetBuilder(), (error, meta, body) => {
    if(error){
        return console.log('ERROR', error.message || error);
    }

    console.log(_catGetBuilder());

    console.log('META INFO');
    console.dir(meta);

    let bodyJSON = JSON.parse(body);
    console.log('BODY');
    console.dir(bodyJSON);

    callback(bodyJSON.response.categories[6].categories[20]);
}); }

var search = (query, callback) => {
    fetchUrl(query, (error, meta, body) => {
        if(error){
            return console.log('ERROR', error.message || error);
        }

        console.log('META INFO');
        console.dir(meta);

        let bodyJSON = JSON.parse(body);
        console.log('BODY');
        console.dir(bodyJSON);

        callback(bodyJSON.response.venues);
    });
}

var search_old = (radius, ll, v, query, callback) => { fetchUrl(_queryBuilder(radius, ll, v, query), (error, meta, body) => {
        if(error){
            return console.log('ERROR', error.message || error);
        }

        console.log(_queryBuilder(radius, ll, v, query));

        console.log('META INFO');
        console.dir(meta);

        let bodyJSON = JSON.parse(body);
        console.log('BODY');
        console.dir(bodyJSON);

        callback(bodyJSON.response.venues);
}); }

exports.categories = getHealthCategories;
exports.search = search;
