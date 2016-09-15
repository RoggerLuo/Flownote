module.exports = angular.module('thread.controller',[])

.controller 'bricksCtrl',($scope,ThreadsHandler,GlobalVar,EditorModal)->
    $scope.assign = (thread)->
        GlobalVar.thread = thread
    ThreadsHandler (data)->
        $scope.bricks = data
    EditorModal $scope

.controller 'settingCtrl', ($scope)->
    true

.controller 'threadListEditor', ($scope,ThreadsHandler,ThreadViewModel,SaveThreadOrder)->
    # data
    ThreadsHandler (data)->
        $scope.bricks = data
    # viewCtrl 
    $scope.viewCtrl = showReorder:false #view control
    $scope.moveItem = (thread, fromIndex, toIndex)-> # reorder function
        $scope.bricks.splice fromIndex, 1
        $scope.bricks.splice toIndex, 0, thread
        orderArr = []
        $scope.bricks.forEach (el,index)->
            orderArr.push {index:index,thread_id:el.thread_id}
        SaveThreadOrder JSON.stringify(orderArr)

    ThreadViewModel $scope


