const express = require('express')
const vatlookupRouter = express.Router()
const axios = require('axios')

vatlookupRouter.get('', async(req, res) => {
    try{
        // lookup given VAT number
        const vat = await axios.get('http://apilayer.net/api/validate?access_key=2eb116f795c84c8e6c5cef74a95a4245&vat_number=LU26375245&format=1')

        // send json response to embedded js 
        res.render('vatlookup', { vatData : vat.data })  // data is here json

    } catch (error) {
        if(error.response) {
            console.log(error.response.data)
        } else if(error.request) {
            console.log(error.request)
        } else {
            console.log('Error', error.message)
        }
    }
});

module.exports = vatlookupRouter
