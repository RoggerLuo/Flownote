require 'angular-resource'

module.exports=angular.module 'app.services',['ngResource']

.factory 'GlobalVar', ->
    {
        thread:{}
        artNum:{}
        calendar:
            weekArr:{}
            weekly:{}
        # rawFilter : false
        # summaryFilter : false
        articles:{
            all:[]
            notAllocated:[]
            hover:[]
            plan:[]
            rootThread:[]
            raw:[]
        }
    }
.factory 'Resource',($resource)->
    # $resource 'http://localhost:3001/api/:method',
    $resource 'http://alice0115.applinzi.com/index.php/ngflow/:method',
        method:'@method',
        {query: 
            method:'JSONP'
            params: 
                callback: 'JSON_CALLBACK'
            isArray:false}

.factory 'RemoveFunc',->
    removeFunc = (val)->
        index = this.indexOf val
        if index > -1
            this.splice index, 1
    removeFunc

