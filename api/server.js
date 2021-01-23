const express = require('express')
const app = express()
const axios = require('axios').default

app.get('/:name', async (req, res) => {

    const response = await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name)
    var films = []
    var current
    for (let index = response.data["page"]; index <= response.data['total_pages']; index++) {

        await axios('https://jsonmock.hackerrank.com/api/movies/search/?Title=' + req.params.name +'&page=' + index).then(function (respon){
          //films.push(respon.data.data.map(m => m.concat(m.Year)))
          respon.data.data.map(m => films.push(m.Year))
                 
        })
        
    }

    
    groupByYears = films.reduce((groups, item) => {
      const group = (groups[item] || [])
      group.push(item)
      console.log('groups[item] ' + groups[item])
      console.log('group ' + group)
      groups[item] = group
      console.log('groups[item] 2 ' + groups[item])
      console.log('groups ' + groups)
      return groups
    }, {})
    
      console.log(groupByYears)
      
        
    return res.json(groupByYears)

})
app.listen('55555')