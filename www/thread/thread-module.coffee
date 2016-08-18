#require './controllers'
require 'angular-resource'
require './services.coffee'

threadModule = angular.module 'thread', ['ngResource']
threadModule.run (ThreadsHandler)->
    ThreadsHandler()

module.exports = threadModule
