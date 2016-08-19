module.exports=angular.module 'thread.services',[]
.factory 'GlobalThread', ->{}

# .factory 'GetThreadList',($http)->
#     $http 
#         method:'JSONP'
#         url:'http://alice0115.applinzi.com/index.php/ngflow/download_thread'
#         params:
#             callback: 'JSON_CALLBACK'

.factory 'Resource',($resource)->
    $resource 'http://alice0115.applinzi.com/index.php/ngflow/:method',
        method:'@method',
            query: 
                method:'JSONP'
                params: 
                    callback: 'JSON_CALLBACK'
                isArray:false
        #用缩进代表一个新参数 区分开 对象            
.factory 'GetThreadsFromStorage', ->
    execute = ->
        storage=window.localStorage;
        all_threads_list=JSON.parse storage.getItem 'all_threads_list'
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

        getSubstance = (item) ->
            JSON.parse storage.getItem 'thread'+item

        newArray = (getSubstance item for item,i in all_threads_list)
        newArray
    execute

.factory 'ThreadsHandler',(Resource,GlobalThread,GetThreadsFromStorage)->
    storage=window.localStorage        
    storeThread = (data)-> #这个data是resource 返回的
        list=[]
        #####根brick####
        thread =
            thread_text:'Roger'
            color:'button-stable'
            stuff:false
            item_list:[]
            thread_id:0
            item_number:0
            father_id:0


        thread_obj=JSON.stringify(thread)
        storage.setItem "thread0",thread_obj
        list.push '0'
        #####根brick#####

        ###resolve data###
        data.forEach (element,index,arra)->
            if not storage.getItem "thread"+element.thread_id
                newThread=
                    thread_id:element.thread_id
                    stuff:element.stuff
                    thread_text:element.thread_text
                    color:element.color

                storage.setItem "thread"+element.thread_id,JSON.stringify newThread
                list.push(element.thread_id);

        storage.setItem "all_threads_list",JSON.stringify list


    execute = (callback)->
        # 貌似一用storage就坏事

        # if storage.getItem "all_threads_list"
        #     data = GetThreadsFromStorage()
            
        #     GlobalThread.bricks = data
        #     callback data

        # else

        promise = Resource.query method:'download_thread' 
        .$promise
        promise.then (res)->
            GlobalThread.bricks = res.data
            GlobalThread.bricks.reverse()
            GlobalThread.bricks.unshift(
                thread_text:'Roger'
                color:'button-stable'
                stuff:false
                item_list:[]
                thread_id:0
                item_number:0
                father_id:0
                )
            callback GlobalThread.bricks
            storeThread res.data

    execute

.factory 'CreateThread',(Resource) -> #增
    storage=window.localStorage        
    execute=(editData)->
        date_and_time=Date.parse(new Date())/1000
        thread_obj=
            thread_text:editData.thread_text
            color:editData.color
            stuff:editData.stuff
            thread_id:date_and_time.toString()

        # 更新单个thread的localstorage
        storage.setItem "thread"+thread_obj.thread_id,JSON.stringify thread_obj

        list=JSON.parse storage.getItem "all_threads_list"
        list.push thread_obj.thread_id
        storage.setItem "all_threads_list",JSON.stringify list

        thread_id=thread_obj.thread_id
        thread_text=thread_obj.thread_text
        color=thread_obj.color
        stuff=thread_obj.stuff

        #接下来该些Resource 8月19日
        promise = Resource.query({method:'thread_create',thread_id:thread_id,thread_text:thread_text,color:color,stuff:stuff}).$promise
        
        promise.then((res)->
            console.log "添加thread成功"
            #应该弹出一个footer
        ,(res)->
            #报错提示
            console.log "添加失败"
        )
        thread_obj
    execute


.factory 'ModifyThread',(Resource) -> # 改
    storage=window.localStorage        
    execute = (thread_obj)->
        thread_id = thread_obj.thread_id.toString()
        thread_text=thread_obj.thread_text
        color=thread_obj.color
        stuff=thread_obj.stuff
        #单个修改localstorage
        storage.setItem "thread"+thread_id,JSON.stringify thread_obj

        promise = Resource.query({method:'thread_modify',thread_id:thread_id,thread_text:thread_text,color:color,stuff:stuff}).$promise
        promise.then((res)->
            #footer提醒
            console.log "修改thread成功"
            true
        ,(res)->
            #warning提醒
            console.log "修改thread失败"
            true
        )

    execute



.factory 'ThreadDelete',(Resource,RemoveFunc) -> # 删
    storage=window.localStorage        
    execute = (thread_obj)->
        thread_id=thread_obj.thread_id.toString()
        #删除thread_list
        list=JSON.parse storage.getItem "all_threads_list"
        RemoveFunc.call list,thread_id
        storage.setItem "all_threads_list",JSON.stringify list

        promise = Resource.query({method:'thread_delete',thread_id:thread_id}).$promise
        promise.then((res)->
            console.log "删除thread成功"
            true
        ,(res)->
            console.log "删除thread失败!"

            true
        )
    execute    

.factory 'RemoveFunc',->
    removeFunc = (val)->
        index = this.indexOf val
        if index > -1
            this.splice index, 1
    removeFunc

