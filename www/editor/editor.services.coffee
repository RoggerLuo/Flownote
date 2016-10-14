module.exports=angular.module 'editor.services',[]
.factory 'EditorService',($ionicModal,EditorAdvanceFunction,CreateArticle,SaveArticle)->
    execute = ($scope)->
        $scope.editor={}
        originalNote={}
        editorModal={}
        createNewArticle = ()->
            {
                content:''
                item_id:'new'
                remind_time:'0'
                remind_text:''
                type:'0'
                thread_id:'0'
            }
        $scope.editor.note = createNewArticle()

        $ionicModal.fromTemplateUrl 'editor/editor-tpl.html', {
            scope: $scope,
            animation: 'slide-in-up'
        }
        .then (modal) ->
            editorModal = modal

        save = ()->
            if $scope.editor.note.item_id is "new"
                if $scope.editor.note.content isnt ""
                    CreateArticle($scope.editor.note).then (res)->
                        console.log 'CreateArticle成功'
                        $scope.editor.onCreateEnd($scope.editor.note)
                        console.log 'onCreate'
                        editorModal.hide()
                else
                    editorModal.hide()
            else
                if $scope.editor.note.content isnt originalNote.content
                    SaveArticle($scope.editor.note.content,$scope.editor.note.item_id).then (res)->
                        console.log 'SaveArticle成功'
                        editorModal.hide()
                else
                    editorModal.hide()
        $scope.editor.preSave = (callback)->
            if $scope.editor.note.item_id is "new"
                if $scope.editor.note.content isnt ""
                    CreateArticle($scope.editor.note).then (res)->
                        console.log 'CreateArticle成功'
                        $scope.editor.onCreateEnd($scope.editor.note)
                        console.log 'onCreate'
                        callback()
            else 
                if $scope.editor.note.content isnt $scope.originContent
                    SaveArticle($scope.editor.note.content,$scope.editor.note.item_id).then (res)->
                        callback()
                        console.log 'SaveArticle成功'
                else
                    callback()

        $scope.editor.onCreateEnd = (note)->'api'
        $scope.editor.onSetRelationEnd = (note)->'api'
        $scope.editor.onSetPlanEnd = (note)->'api'
        $scope.editor.onSetClockEnd = (note)->'api'

        $scope.editor.openEditorModal = (note)->
            editorModal.show()
            if note is 'new'
                $scope.editor.note = createNewArticle()
            else 
                $scope.editor.note = note

            originalNote = JSON.parse JSON.stringify $scope.editor.note
            # 感觉放这里不合适，不过暂时没有更好的方法# 以后再慢慢做测试
            element = document.querySelector('.keyboard-attach')
            element.addEventListener "touchstart", (e)->
                e.preventDefault()
            element2 = document.querySelector('.keyboard-attach2')
            element2.addEventListener "touchstart", (e)->
                e.preventDefault()

        $scope.editor.closeEditorModal = ->
            save()

        $scope.editor.newEditorModal = ->
            $scope.editor.preSave ()->
                promise = editorModal.hide()
                promise.then (res)->
                    $scope.editor.openEditorModal 'new'                
        
        # Cleanup the modal when we're done with it!
        $scope.$on '$destroy',->
            if editorModal.remove?
                editorModal.remove()
        # Execute action on hide modal
        $scope.$on 'modal.hidden', ->
            # Execute action
        # Execute action on remove modal
        $scope.$on 'modal.removed', ->
            # Execute action

        EditorAdvanceFunction $scope

    execute

.factory 'EditorAdvanceFunction',(EditorThreadModal,SetRelation,SetClock,SetType,$ionicPopup,$timeout,SaveArticle,CreateArticle)->
    execute = ($scope)->
        # setRelation 和 setClock都要考虑在两种情况下的使用
        # setRelation
        $scope.editor.setRelation = (thread)->
            $scope.threadmodal.hide() #先隐藏modal
            $scope.editor.preSave ()->
                $scope.editor.note.thread_id = thread.thread_id
                promise = SetRelation $scope.editor.note.item_id,thread
                promise.then (res)->
                    console.log 'SetRelation成功'
                ,(res)->
                    console.log 'SetRelation失败'
                    alertPopup = $ionicPopup.show
                        title: '操作失败！'
                        template: '<div style="text-align:center;"><span>分类设置为'+thread.thread_text+'失败！</span></div>' 
                    $timeout(()->
                         alertPopup.close()  #close the popup after 3 seconds for some reason
                    , 600)

                $scope.editor.onSetRelationEnd($scope.editor.note)

        # setClock
        clockPopup = {}
        doubleClickLock=false
        $scope.editor.showSetClockModal = (note = 'null',$event)->
            if $event?
                $event.stopPropagation()
            if doubleClickLock
                return false  
            doubleClickLock = true
            if note!='null'
                $scope.editor.note=note
                $scope.editor.originContent = note.content #为了不多保存一次
            $scope.editor.preSave ()->
                clockPopup = $ionicPopup.show {
                    template:require './clock-popup.html'
                    title: '选择提醒周期'
                    scope: $scope
                }
            $timeout ()->
                doubleClickLock=false 
            , 1000

        $scope.editor.clockClose= ->
            clockPopup.close() #close the popup after 3 seconds for some reason
        
        $scope.editor.setPeriod = (para)->         
            SetClock $scope.editor.note,para*24*60*60
            if $scope.editor.note.type isnt '2'
                SetType $scope.editor.note,'2'
                $scope.editor.note.type = '2'
            $scope.editor.onSetClockEnd($scope.editor.note)
            clockPopup.close()
        
        # setPlan
        $scope.editor.setPlan = ->
            $scope.editor.preSave ()->
                alertPopup = $ionicPopup.show
                    title: '操作成功',
                    template: '<div style="text-align:center;"><span>类型设置为计划</span></div>' 
                $timeout(()->
                     alertPopup.close()  #close the popup after 3 seconds for some reason
                , 600)
                SetType $scope.editor.note,'1'
                $scope.editor.note.type = '1'
                $scope.editor.onSetPlanEnd($scope.editor.note)
        
        EditorThreadModal $scope

    execute

.factory 'EditorThreadModal',($ionicModal,ThreadsHandler)->
    execute = ($scope)->

        $ionicModal.fromTemplateUrl 'thread/mini-bricks.html', 
            scope: $scope,
            animation: 'slide-in-up'
        .then (modal)->
            $scope.threadmodal = modal
        
        $scope.editor.showSetRelationModal =(note='empty')->
            if note!='empty'
                $scope.editor.note=note
                $scope.editor.originContent = note.content #为了不多保存一次
            $scope.threadmodal.show()
            ThreadsHandler (data)->
                $scope.bricks=data

        $scope.closeThreadModal = ->
            $scope.threadmodal.hide()

        # Cleanup the modal when we're done with it!
        $scope.$on '$destroy', ->
            if $scope.threadmodal?
                if $scope.threadmodal.remove?
                    $scope.threadmodal.remove()
        # Execute action on hide modal
        $scope.$on 'modal.hidden', ->
            # Execute action
        # Execute action on remove modal
        $scope.$on 'modal.removed', ->
            # Execute action
    execute
