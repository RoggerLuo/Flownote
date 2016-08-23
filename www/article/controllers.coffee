module.exports = angular.module('article.controller',[])
.controller 'planCtrl',($scope,GetArticles,GlobalVar,$ionicLoading,EditorModal)->
    $scope.title = GlobalVar.thread.thread_text
    $scope.category = $scope.title
    $scope.$on '$ionicView.enter', (e)->
        $ionicLoading.show template: 'Loading...'
        GetArticles({thread:GlobalVar.thread.thread_id,type:1}).then (res)->
            $scope.articles=res.data
            GlobalVar.thread.type1=$scope.articles.length
            $ionicLoading.hide()
    EditorModal $scope #用modal，封装了公共函数


.controller 'commonCtrl',($scope,GetArticles,GlobalVar,$ionicLoading,EditorModal)->    
    $scope.title = GlobalVar.thread.thread_text
    $scope.category = $scope.title
    $scope.$on '$ionicView.enter', (e)->
        $ionicLoading.show template: 'Loading...'
        GetArticles({thread:GlobalVar.thread.thread_id,type:0}).then (res)->
            $scope.articles=res.data
            GlobalVar.thread.type0=$scope.articles.length
            $ionicLoading.hide()
    EditorModal $scope

.controller 'hoverCtrl',($scope,GetArticles,GlobalVar,addDecimal,$location,$ionicLoading,EditorModal)->
    $scope.title=GlobalVar.thread.thread_text
    $scope.category = $scope.title
    
    $scope.$on '$ionicView.enter', (e)->
        $ionicLoading.show template: 'Loading...'
        GetArticles({thread:GlobalVar.thread.thread_id,type:2}).then (res)->
            data = addDecimal res.data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
            $scope.articles = data
            GlobalVar.thread.type2=$scope.articles.length
            $ionicLoading.hide()
    EditorModal $scope

    
