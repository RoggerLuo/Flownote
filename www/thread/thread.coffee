require 'angular-resource'
module.exports = angular.module 'thread', [
    'ngResource',
    require('./controllers.coffee').name,
    require('./services.coffee').name
    ]