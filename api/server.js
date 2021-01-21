const express = require('express')
const app = express()
const axios = require('axios').default

app.get('/:name', async (req, res) => {

    const response = await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name)
    var fils = []

    for (let index = response.data["page"]; index <= response.data['total_pages']; index++) {

        await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name +'&page=' + index).then(function (respon){
           fils.push(respon.data['data'])
        })
        console.log(fils.length)

    }
    console.log(fils)
    return res.json(response.data)

})
app.listen('55555')