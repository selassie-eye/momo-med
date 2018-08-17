var fetchUrl = require('fetch').fetchUrl;

const baseURL = 'https://api.foursquare.com/v2/venues/explore';

var clientID = '1MV24XBQKT1231E3PZPXOLKS32AX3DQLEZP21D1R0TYTL1I0';
var clientSecret = 'GA1Z3CUGDTBPYTBIP4DHDUR1LXTPJX3TKRELITHF43OGHNMP';

function _queryBuilder(radius, ll, v, query) {
    return baseURL + '?' +
        `client_id=${clientID}` + '&' +
        `client_secret=${clientSecret}` + '&' +
        `v=${v}` + '&' +
        `ll=${ll}` + '&' +
        `query=${query}`
}

var search = (radius, ll, v, query, callback) => { fetchUrl(_queryBuilder(radius, ll, v, query), (error, meta, body) => {
        if(error){
            return console.log('ERROR', error.message || error);
        }

        console.log(_queryBuilder(radius, ll, v, query));

        console.log('META INFO');
        console.dir(meta);

        let bodyJSON = JSON.parse(body);
        console.log('BODY');
        console.dir(bodyJSON);

        callback(bodyJSON.response.groups[0].items);
}); }

exports.search = search;
