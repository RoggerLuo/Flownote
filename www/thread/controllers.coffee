module.exports = angular.module 'thread.controller', []
.controller 'bricksCtrl',($scope,ThreadsHandler,GlobalVar,EditorService)->
    EditorService $scope
    $scope.assign = (thread)->
        GlobalVar.thread = thread
    ThreadsHandler (data)->
        $scope.bricks = data

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

.controller 'planCtrl',($scope,Db,List,Lazyload,GlobalVar,ThreadViewModel)->    
    $scope.title = GlobalVar.thread.thread_text
    List $scope
    ThreadViewModel $scope
    $scope.refresh = ->
        notes = Db.items.query({thread:GlobalVar.thread.thread_id,type:'1'}).reverse()
        $scope.list.notes=[]
        Lazyload $scope,notes
    
    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()

.controller 'commonCtrl',($scope,Db,addDecimal,List,Lazyload,GlobalVar,ThreadViewModel)->    
    $scope.title = GlobalVar.thread.thread_text
    List $scope
    ThreadViewModel $scope

    $scope.refresh = ->
        notes = Db.items.query({thread:GlobalVar.thread.thread_id}).reverse()
        notes = addDecimal notes
        notes.sort (a,b)->
            -(a["decimal"] - b["decimal"])
        $scope.list.notes=[]
        Lazyload $scope,notes
    
    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()


.controller 'hoverCtrl',($scope,Db,List,Lazyload,GlobalVar,ThreadViewModel,addDecimal)->    
    $scope.title = GlobalVar.thread.thread_text
    List $scope
    ThreadViewModel $scope
    $scope.refresh = ->
        notes = Db.items.query({thread:GlobalVar.thread.thread_id,type:'2'}).reverse()
        notes = addDecimal notes
        notes.sort (a,b)->
            -(a["decimal"] - b["decimal"])
        $scope.list.notes=[]
        Lazyload $scope,notes
    
    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()
