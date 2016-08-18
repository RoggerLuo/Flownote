threadModule = require './thread-module.coffee'
#debugger
threadModule
.factory 'GlobalThread', ->{}

.factory 'GetThreadList',($http)->
    $http 
        method:'JSONP'
        url:'http://alice0115.applinzi.com/index.php/ngflow/download_thread'
        params:
            callback: 'JSON_CALLBACK'

.factory 'Resource',($resource)->
    $resource 'http://alice0115.applinzi.com/index.php/ngflow/:method',
        method:'@method',
            query: 
                method:'JSONP'
                params: 
                    callback: 'JSON_CALLBACK'
                isArray:false
        #用缩进代表一个新参数 区分开 对象            
.factory 'GetThreads', ->
    execute=->
        storage=window.localStorage;
        all_threads_list=storage.getItem('all_threads_list');
        all_threads_list=JSON.parse(all_threads_list);
        
        #
        #threads=[];
        #mapArray = all_threads_list.map (value,index,arr)->
        #    JSON.parse storage.getItem 'thread'+all_threads_list[i]
        
        #使用原始方式实现
        #threads=[];
        #for (var i = 0; i < all_threads_list.length; i++) {
        #    threads.unshift( JSON.parse(storage.getItem('thread'+all_threads_list[i])));
        #}
        #threads

        getSubstance = (item)->
            JSON.parse storage.getItem 'thread'+all_threads_list[i]
        newArray = (getSubstance item for item,i in all_threads_list)
        newArray
    execute

.factory 'ThreadsHandler', (Resource,GlobalThread)->
    storage=window.localStorage        
    storeThread = (data)-> #这个data是resource 返回的
        list=[]
        
        #####根brick####
        thread =
            text:'Roger'
            color:'button-stable'
            stuff:false
            item_list:[]
            thread_id:0
            item_number:0
            father_id:0
        
        thread_obj=JSON.stringify(thread)
        storage.setItem "thread0",thread_obj
        list.unshift '0'
        #####根brick#####

        ###resolve data###
        data.forEach (elment,index,arra)->
            if not storage.getItem "thread"+element.thread_id
                newThread=
                    thread_id:element.thread_id
                    stuff:element.stuff
                    text:element.thread_text
                    color:element.color
                    item_list:[]

                storage.setItem "thread"+element.thread_id,JSON.stringify newThread

                list.unshift(element.thread_id);

        storage.setItem "all_threads_list",JSON.stringify list


    execute=->
        promise = Resource.query method:'download_thread' 
        .$promise
        promise.then (res)->
            GlobalThread.bricks = res.data
            storeThread(res.data)

    execute
