module.exports=angular.module 'article.services',[]

.factory 'EditorModal',($ionicModal,RemoveFunc,SaveArticle)->
    execute = ($scope)->
        # /* ionicModal */
        originContent = ''
        $ionicModal.fromTemplateUrl 'article/editor-modal.html', {
            scope: $scope,
            animation: 'slide-in-up'
        }
        .then (modal) ->
            $scope.modal = modal
        
        $scope.openModal = (article) ->
            $scope.modal.show()
            $scope.article = article
            $scope.show = true
            originContent = $scope.article.content        

        $scope.closeModal = ->
            if $scope.article.content isnt originContent
                SaveArticle($scope.article.content,$scope.article.item_id)
            $scope.modal.hide()
        # Cleanup the modal when we're done with it!
        $scope.$on '$destroy', ->
            $scope.modal.remove()
        # Execute action on hide modal
        $scope.$on 'modal.hidden', ->
            # Execute action
        # Execute action on remove modal
        $scope.$on 'modal.removed', ->
            # Execute action
        $scope.remove = (article)-> # 删
            r = confirm "确定要删除"+$scope.article.content.slice(0,10)+"?"
            if r
                DeleteArticle(article.item_id)
                RemoveFunc.call $scope.articles,article        
        $scope.stopPro = ($event)->
            cordova.plugins.Keyboard.close()

.factory 'addDecimal',->
    storage = window.localStorage 
    execute = (data)->
        data.forEach (el,index,arr)->
            decimal=(Date.parse(new Date()) - Date.parse(new Date(el.date_and_time*1000)))/(el.remind_time*1000-el.date_and_time*1000)              
            style = 'button-stable' 
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
            console.log 'CreateArticle成功'
        ,(res)->
            console.log 'CreateArticle失败'
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
    execute = (item_id,type)->
        item_id=item_id.toString()#转换成字符串
        promise = Resource.query({method:'change_type',item_id:item_id,type:type}).$promise
        promise.then (res)->
            console.log 'SetRelation成功'
        ,(res)->
            console.log 'SetRelation失败'
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
        item_obj.remind_time=(item_obj.date_and_time-0)+(seconds-0)
        words=item_obj.remind_text
        promise = Resource.query({method:'set_timer',item_id:item_id,seconds:seconds,words:words}).$promise
        promise.then (res)->
           console.log 'SetClock成功'
        ,(res)->
           console.log 'SetClock失败'
    execute