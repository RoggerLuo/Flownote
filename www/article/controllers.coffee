module.exports = angular.module('article.controller',[])
.controller 'planCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles)->
    # 重构，代码重用
    $scope.title = GlobalVar.thread.thread_text
    $scope.category = $scope.title
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:1},(data)->
        $scope.articles=data
        GlobalVar.thread.type1=$scope.articles.length
        return data
    EditorModal $scope

.controller 'commonCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles)->    
    $scope.title = GlobalVar.thread.thread_text
    $scope.category = $scope.title
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:0},(data)->
        $scope.articles=data
        GlobalVar.thread.type0=$scope.articles.length
        return data
    EditorModal $scope

.controller 'hoverCtrl',($scope,GetArticles,GlobalVar,addDecimal,$location,$ionicLoading,EditorModal,FillScopeArticles)->
    $scope.title = GlobalVar.thread.thread_text
    $scope.category = $scope.title
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:2},(data)->
        
        data = addDecimal data
        data.sort (a,b)->
            -(a["decimal"] - b["decimal"])
        $scope.articles=data
        GlobalVar.thread.type2=$scope.articles.length
        return data
    EditorModal $scope

    
