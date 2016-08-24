require 'angular-resource'
module.exports = angular.module 'setting', [
    'ngResource',
    require('./controllers.coffee').name,
    require('./services.coffee').name
    ]

