module.exports=angular.module 'editor.services',[]
.factory 'EditorFunction',(EditorThreadModal,SetRelation,SetClock,SetType,$ionicPopup,$timeout)->
    execute = ($scope)->
        EditorThreadModal $scope
        # setRelation
        $scope.setRelation = (thread)->
            # cordova.plugins.Keyboard.close()
            SetRelation $scope.article.item_id,thread.thread_id
            $scope.category = thread.thread_text
            $scope.threadmodal.hide()

        # 加载这个里面一起 popup with modal
        # setType2 hover
        $scope.showPopup = ()->
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



.factory 'EditorModal',($ionicModal,RemoveFunc,SaveArticle,DeleteArticle)->
    execute = ($scope)->
        # /* ionicModal */
        originContent = ''
        $ionicModal.fromTemplateUrl 'editor/modal.html', {
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
            
            element=document.querySelector('.keyboard-attach')
            element.addEventListener "touchstart", (e)->
                e.preventDefault()

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
            r = confirm "确定要删除"+article.content.slice(0,10)+"?"
            if r
                DeleteArticle(article.item_id)
                RemoveFunc.call $scope.articles,article        
        $scope.stopPro = ($event)->
            cordova.plugins.Keyboard.close()
