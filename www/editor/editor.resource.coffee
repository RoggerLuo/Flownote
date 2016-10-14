module.exports=angular.module 'editor.resource',[]

.factory 'CreateArticle',(Resource,Db)->
    execute = (article)->
        article.date_and_time=Date.parse(new Date())/1000
        article.item_id = article.date_and_time.toString()
        Db.items.insert article
        promise = Resource.query({method:'item_create',content:article.content,item_id:article.item_id,date_and_time:article.date_and_time}).$promise
        # promise.then (res)->
        #     console.log 'CreateArticle成功'
        # ,(res)->
        #     console.log 'CreateArticle失败'
    execute

.factory 'SetRelation',(Resource,$ionicPopup,$timeout)->
    execute = (item_id,thread)->
        item_id=item_id.toString()#转换成字符串
        thread_id=thread.thread_id.toString()#转换成字符串
        promise = Resource.query({method:'item_to_thread',thread_id:thread_id,item_id:item_id}).$promise
    execute


.factory 'DeleteArticle',(Resource,Db)->
    execute=(article)->
        item_id=article.item_id.toString()#转换成字符串
        promise = Resource.query({method:'item_delete',item_id:article.item_id}).$promise
        promise.then (res)->
            Db.items.remove article
            console.log 'DeleteArticle成功'
        ,(res)->
            console.log 'DeleteArticle失败'
    execute
               
.factory 'SaveArticle',(Resource)->
    execute = (content,item_id)->
        item_id=item_id.toString()#转换成字符串        
        promise = Resource.query({method:'item_saveContent',content:content,item_id:item_id}).$promise
        # promise.then (res)->
        #     console.log 'SaveArticle成功'
        # ,(res)->
        #     console.log 'SaveArticle失败'
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

