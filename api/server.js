const cors = require('cors')
const express = require('express');
const app = express();
const axios = require('axios').default;

app.use(cors())

app.get('/', async (req, res) => {
  const  response = await axios(
    'https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.query.name
  );
  var moviesByYearsResult = [];

  for (let index = response.data['page']; index <= response.data['total_pages']; index++) {
    await axios(
      'https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.query.name + '&page=' + index
    ).then(function (response) {
      response.data.data.map((m) => moviesByYearsResult.push(m.Year));
    });
  }

  moviesByYear = { moviesByYear: [] };

  agroupByYear = moviesByYearsResult.reduce((groups, year) => {
    const group = groups[year] || [];
    group.push(year);
    groups[year] = group;
    return groups;
  }, {});

  for (var year in agroupByYear) {
    moviesByYear.moviesByYear.push({
      year: year,
      movies: agroupByYear[year].length,
    });
   
  }

  moviesByYear.total = response.data['total'];
  return res.json(moviesByYear);

});

app.listen('55555');
