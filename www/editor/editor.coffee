require 'angular-resource'
module.exports = angular.module 'editor', [
    'ngResource',
    require('./controllers.coffee').name,
    require('./services.coffee').name
    ]

