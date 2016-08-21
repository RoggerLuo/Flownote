module.exports = angular.module('thread.controller',[])

.controller 'bricksCtrl',($scope,ThreadsHandler,GlobalVar)->
    $scope.assign=(thread_id)->
        GlobalVar.thread_id = thread_id
    ThreadsHandler (data)->
        $scope.bricks=data

.controller 'settingCtrl', ($scope)->
    true

.controller 'threadEditor', ($scope,ThreadsHandler,$ionicModal,CreateThread,ModifyThread,ThreadDelete)->
    # data
    ThreadsHandler (data)->
        $scope.bricks=data
    # viewCtrl 
    $scope.viewCtrl = showReorder:false #view control
    $scope.moveItem = (thread, fromIndex, toIndex)-> # reorder function
        $scope.bricks.splice fromIndex, 1
        $scope.bricks.splice toIndex, 0, thread
        result=[]
        for brick in $scope.bricks
            result.unshift brick.thread_id 
        # window.localStorage.setItem "all_threads_list",JSON.stringify result

    ###########
    ## Modal ##
    ###########
    # Modal data and logic
    $scope.originalData = {}
    $scope.editData =
        thread_text:''
        color:'button-stable'
        stuff:'false'
        thread_id:'new'

    $scope.cancel = ->
        $scope.editData.text=$scope.originalData.text
        $scope.editData.color=$scope.originalData.color
        $scope.editData.stuff=$scope.originalData.stuff
        $scope.modal.hide()

   

    $ionicModal.fromTemplateUrl 'setting/thread-modal.html', {
        scope: $scope,
        animation: 'slide-in-up'
        }
    .then (modal) ->
        $scope.modal = modal
    
    $scope.openModal = (thread) ->
        $scope.modal.show()
        if thread?
            $scope.editData = thread
            $scope.originalData = JSON.parse JSON.stringify thread 
    
    $scope.closeModal = ->
        $scope.modal.hide()

    $scope.$on '$destroy', ->
        $scope.modal.remove()
    
    $scope.$on 'modal.hidden', ->
        true    
    $scope.$on 'modal.removed', ->
        true

    $scope.create=->
        if $scope.editData.thread_text ==""
            return  false
        
        if $scope.editData.thread_id == 'new'  # 增
            obj = CreateThread $scope.editData
            $scope.bricks.unshift obj              
        
        else                                 # 改
            if $scope.originalData.thread_text!=$scope.editData.thread_text||$scope.originalData.color!=$scope.editData.color||$scope.originalData.stuff!=$scope.editData.stuff
                ModifyThread $scope.editData

            
    $scope.remove = (thread) -> # 删
        
        r = confirm "请先清空分类下的文章,确定要删除"+thread.thread_text+"?"

        if r
            $scope.bricks.splice $scope.bricks.indexOf(thread), 1
            ThreadDelete thread
        
    # .controller('threadEdit',function($scope,instance,Get_threads,Get_items_by_type_and_thread,$ionicModal,Operation_handler){
    #     在angular开发中angular controller never 包含DOM元素（html/css），在controller需要一个简单的POJO（plain object javascript object），与view完全的隔离（交互angularjs框架的职责
    #     不建议将class放入controller scope之上，scope需要保持纯洁行，scope上的只能是数据和行为

