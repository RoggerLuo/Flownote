module.exports=angular.module 'article.services',[]
.factory 'DecimalFilter',->
    execute = (data)->
        data.forEach (el,index,arr)->
            style = 'button-stable' 
            decimal = 0
            distance = Date.parse(new Date()) - el.remind_time*1000
            if distance > 0 
                decimal = 1
            if distance > 24*60*60*3 
                decimal = 2
            if distance > 24*60*60*7
                decimal = 3
            if decimal >= 1
                style = 'button-positive' 
            if decimal >= 2 
                style = 'button-energized' 
            if decimal >= 3
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
            # if decimal < 1
                # arr.splice index, 1
        data
    execute

.factory 'addDecimal',->
    execute = (data)->
        data.forEach (el,index,arr)->
            style = 'button-stable' 
            decimal = 0
            distance = Date.parse(new Date()) - el.remind_time*1000
            if distance > 0 
                decimal = 1
            if distance > 24*60*60*3 
                decimal = 2
            if distance > 24*60*60*7
                decimal = 3
        
            if decimal >= 1
                style = 'button-positive' 
            if decimal >= 2 
                style = 'button-energized' 
            if decimal >= 3
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
        data
    execute

.factory 'GetArticles',(Resource)->
    (data)->
        thread = ''
        type = '' 
        day=''
        week=''
        if data.thread?
            thread = data.thread
        if data.type?
            type = data.type
        if data.day?
            day = data.day
        if data.week?
            week = data.week
        Resource.query({method:'get_item',thread_id:thread,type:type,day:day,week:week}).$promise
    #     promise.then (res)->
    #         console.log 'get_item成功'
    #     ,(res)->
    #         console.log 'get_item失败'
    # execute

.factory 'CreateArticle',(Resource)->
    execute = (content)->
        date_and_time=Date.parse(new Date())/1000
        item =
            content:content
            date_and_time:date_and_time
            item_id:date_and_time.toString()
            remind_time:'0'
            remind_text:''
            type:'0'
            type2:'0'
            thread_id:'0'
        item_id=item.item_id
        content=item.content
        date_and_time=item.date_and_time
        promise = Resource.query({method:'item_create',content:content,item_id:item_id,date_and_time:date_and_time}).$promise
        promise.then (res)->
            console.log 'CreateArticle成功'
        ,(res)->
            console.log 'CreateArticle失败'
    execute

.factory 'DeleteArticle',(Resource)->
    execute=(item_id)->
        item_id=item_id.toString()#转换成字符串
        promise = Resource.query({method:'item_delete',item_id:item_id}).$promise
        promise.then (res)->
            console.log 'DeleteArticle成功'
        ,(res)->
            console.log 'DeleteArticle失败'
    execute
               
.factory 'SaveArticle',(Resource)->
    execute = (content,item_id)->
        item_id=item_id.toString()#转换成字符串        
        promise = Resource.query({method:'item_saveContent',content:content,item_id:item_id}).$promise
        promise.then (res)->
            console.log 'SaveArticle成功'
        ,(res)->
            console.log 'SaveArticle失败'
    execute


.factory 'SetRelation',(Resource)->
    execute = (item_id,thread_id)->
        item_id=item_id.toString()#转换成字符串
        thread_id=thread_id.toString()#转换成字符串
        promise = Resource.query({method:'item_to_thread',thread_id:thread_id,item_id:item_id}).$promise
        promise.then (res)->
            console.log 'SetRelation成功'
        ,(res)->
            console.log 'SetRelation失败'
    execute


.factory 'SetType',(Resource)->
    execute = (item_obj,type)->
        item_id=item_obj.item_id.toString()#转换成字符串
        promise = Resource.query({method:'change_type',item_id:item_id,type:type}).$promise
        promise.then (res)->
            console.log 'SetType成功'
        ,(res)->
            console.log 'SetType失败'
    execute

.factory 'Reclock',(Resource)->
    execute = (item_obj)->
        item_id=item_obj.item_id.toString()#转换成字符串

        seconds=item_obj.remind_time-item_obj.date_and_time
        item_obj.date_and_time=Date.parse(new Date())/1000
        item_obj.remind_time=item_obj.date_and_time+seconds

        promise = Resource.query({method:'refresh_timer',item_id:item_id}).$promise
        promise.then (res)->
            console.log 'Reclock成功'
        ,(res)->
            console.log 'Reclock失败'
    execute


.factory 'SetClock',(Resource)->
    execute = (item_obj,seconds)->
        item_id=item_obj.item_id
        item_obj.remind_time=Date.parse(new Date())/1000 + (seconds-0)
        words=item_obj.remind_text
        promise = Resource.query({method:'set_timer',item_id:item_id,seconds:seconds,words:words}).$promise
        promise.then (res)->
           console.log 'SetClock成功'
        ,(res)->
           console.log 'SetClock失败'
    execute