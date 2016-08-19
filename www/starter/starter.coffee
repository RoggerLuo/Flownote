#require '../lib/ng.js'

module.exports = angular.module 'starter', [
    require('./controllers.coffee').name,
    require('./services.coffee').name
]
    
