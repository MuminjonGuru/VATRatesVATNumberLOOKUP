const express = require('express')
const app     = express()
const port    = 2505

app.use(express.static('public'))
app.use('/css', express.static(__dirname + 'public/css'))
app.use('/js', express.static(__dirname + 'public/js'))

app.set('views', './src/views')
app.set('view engine', 'ejs')

// set vatlookupRouter for /vatlookup endpoint
const vatlookupRouter = require('./src/routes/vatlookup')
app.use('/vatlookup', vatlookupRouter)

app.listen(port, () => console.log(`Listening on port ${port}`))
