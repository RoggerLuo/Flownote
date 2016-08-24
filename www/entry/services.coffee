module.exports=angular.module 'app.services',[]
.factory 'GlobalVar', ->
    {
        thread:{}
        number:{}
        calendar:
            weekArr:{}
            weekly:{}
            config:{}
    }
.factory 'Resource',($resource)->
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

