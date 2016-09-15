#require '../lib/ng.js'

module.exports = angular.module 'calendar', [
    require('./controllers.coffee').name,
    require('./services.coffee').name
]
    
