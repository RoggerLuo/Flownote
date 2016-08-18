require 'angular-resource'
#require './controllers'
#require './services.coffee'

module.exports = angular.module 'thread', [
    'ngResource',
    require('./controllers.coffee').name,
    ]

.run (ThreadsHandler)->
    ThreadsHandler()

