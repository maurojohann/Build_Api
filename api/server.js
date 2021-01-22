const express = require('express')
const app = express()
const axios = require('axios').default

app.get('/:name', async (req, res) => {

    const response = await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name)
    var fils = []
    var current
    for (let index = response.data["page"]; index <= response.data['total_pages']; index++) {

        await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name +'&page=' + index).then(function (respon){
          //fils.push(respon.data.data.map(m => m.concat(m.Year)))
          respon.data.data.map(m => fils.push(m.Year))
          
        })
        
    }
  
    console.log(fils)
    return res.json(fils)

})
app.listen('55555')