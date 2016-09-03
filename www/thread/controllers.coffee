module.exports = angular.module('thread.controller',[])

.controller 'bricksCtrl',($scope,ThreadsHandler,GlobalVar,EditorModal)->
    $scope.assign = (thread)->
        GlobalVar.thread = thread
    ThreadsHandler (data)->
        $scope.bricks = data
    EditorModal $scope

.controller 'settingCtrl', ($scope)->
    true

.controller 'threadEditor', ($scope,ThreadsHandler,ThreadViewModel)->
    # data
    ThreadsHandler (data)->
        $scope.bricks = data
    # viewCtrl 
    $scope.viewCtrl = showReorder:false #view control
    $scope.moveItem = (thread, fromIndex, toIndex)-> # reorder function
        $scope.bricks.splice fromIndex, 1
        $scope.bricks.splice toIndex, 0, thread
        result=[]
        for brick in $scope.bricks
            result.unshift brick.thread_id 
        # window.localStorage.setItem "all_threads_list",JSON.stringify result

    ThreadViewModel $scope
        
    # .controller('threadEdit',function($scope,instance,Get_threads,Get_items_by_type_and_thread,$ionicModal,Operation_handler){
    #     在angular开发中angular controller never 包含DOM元素（html/css），在controller需要一个简单的POJO（plain object javascript object），与view完全的隔离（交互angularjs框架的职责
    #     不建议将class放入controller scope之上，scope需要保持纯洁行，scope上的只能是数据和行为

