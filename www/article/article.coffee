require 'angular-resource'
module.exports = angular.module 'article', [
    'ngResource',
    require('./controllers.coffee').name,
    require('./services.coffee').name
    ]

