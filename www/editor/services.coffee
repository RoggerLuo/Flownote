module.exports=angular.module 'editor.services',[]

.factory 'EditorModal',($ionicModal,EditorFunction,CreateArticle,SaveArticle)->
    whenOpenModal = ($scope,article)->
        element=document.querySelector('.keyboard-attach')
        element.addEventListener "touchstart", (e)->
            e.preventDefault()
        window.addEventListener('native.keyboardshow', keyboardShowHandler)
        window.addEventListener('native.keyboardhide', keyboardHideHandler)
        keyboardHideHandler = (e)->
            $scope.show = false
        keyboardShowHandler = (e)->
            $scope.show = true
        $scope.stopPro = ($event)->
            cordova.plugins.Keyboard.close()
        $scope.show = true
        if article is 'new'
            $scope.article = {
                content:''
                item_id:'new'
                remind_time:'0'
                remind_text:''
                type:'0'
                thread_id:'0'
            }
        else 
            $scope.article = article
        $scope.originContent = $scope.article.content
        $scope.$on "$ionicView.beforeLeave", (event, data)-> #为了后退的时候能够保存

    whenCloseModal = ($scope)->
        if $scope.article.item_id is "new"
            if $scope.article.content isnt ""
                CreateArticle($scope.article.content)
        else
            if $scope.article.content isnt $scope.originContent
                SaveArticle($scope.article.content,$scope.article.item_id)
    execute = ($scope)->
        EditorFunction $scope
        $ionicModal.fromTemplateUrl 'editor/modal.html', {
            scope: $scope,
            animation: 'slide-in-up'
        }
        .then (modal) ->
            $scope.modal = modal
        $scope.openModal = (article) ->
            $scope.modal.show()
            whenOpenModal $scope,article
        $scope.closeModal = ->
            whenCloseModal $scope            
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
    execute

.factory 'EditorFunction',(EditorThreadModal,SetRelation,SetClock,SetType,$ionicPopup,$timeout,SaveArticle,CreateArticle)->
    execute = ($scope)->
        EditorThreadModal $scope

        $scope.preSave = ->
            if $scope.article.item_id is "new"
                if article.content isnt ""
                    CreateArticle(article.content)
                    return 'ready'
            else 
                if $scope.article.content isnt $scope.originContent
                    SaveArticle($scope.article.content,$scope.article.item_id)
                return 'ready'

        # setRelation
        $scope.setRelation = (thread)->
            return false if $scope.preSave() isnt 'ready'
            cordova.plugins.Keyboard.close()
            SetRelation $scope.article.item_id,thread.thread_id
            $scope.category = thread.thread_text
            $scope.threadmodal.hide()


        # 加载这个里面一起 popup with modal
        # setType2 hover
        $scope.showPopup = ()->
            return false if $scope.preSave() isnt 'ready'
            $scope.data = {}
            myPopup = $ionicPopup.show {
                templateUrl:'editor/hover-popup.html'
                title: 'Choose period'
                scope: $scope
            }
            $scope.popupClose= ->
                myPopup.close() #close the popup after 3 seconds for some reason
            $scope.setPeriod = (para)->         
                SetClock $scope.article,para*24*60*60
                if $scope.article.type isnt '2'
                    SetType $scope.article,'2'
                    $scope.article.type = '2'
                myPopup.close()
        
        # setPlan
        $scope.setPlan = ->
            return false if $scope.preSave() isnt 'ready'
            alertPopup = $ionicPopup.show
                title: 'Type has changed to "Plan"',
                template: '&nbsp;&nbsp;&nbsp;&nbsp; Success ! '
            $timeout(()->
                 alertPopup.close()  #close the popup after 3 seconds for some reason
            , 1000)
            SetType $scope.article,'1'
            $scope.article.type = '1'

    execute
.factory 'EditorThreadModal',($ionicModal,ThreadsHandler)->
    execute = ($scope)->
        $ionicModal.fromTemplateUrl 'editor/threadmodal.html', 
            scope: $scope,
            animation: 'slide-in-up'
        .then (modal)->
            $scope.threadmodal = modal
        $scope.openThreadModal = ->
            $scope.threadmodal.show()
            ThreadsHandler (data)->
                $scope.bricks=data
        $scope.closeThreadModal = ->
            $scope.threadmodal.hide()
        # Cleanup the modal when we're done with it!
        $scope.$on '$destroy', ->
            $scope.threadmodal.remove()
        # Execute action on hide modal
        $scope.$on 'modal.hidden', ->
            # Execute action
        # Execute action on remove modal
        $scope.$on 'modal.removed', ->
            # Execute action
    execute



.factory 'CreateArticle',(Resource)->
    execute = (article)->
        article.date_and_time=Date.parse(new Date())/1000
        article.item_id = date_and_time.toString()        
        promise = Resource.query({method:'item_create',content:article.content,item_id:article.item_id,date_and_time:article.date_and_time}).$promise
        promise.then (res)->
            console.log 'CreateArticle成功'
        ,(res)->
            console.log 'CreateArticle失败'
    execute