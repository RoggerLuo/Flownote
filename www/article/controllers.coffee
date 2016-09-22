module.exports = angular.module('article.controller',[])

.controller 'articlesCtrl', ($scope,EditorModal,FillScopeArticles)-> 
    EditorModal $scope
    FillScopeArticles $scope,{}
    
.controller 'planCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles,ThreadViewModel)->
    $scope.title = GlobalVar.thread.thread_text
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:1},(data)->
        $scope.articles=data
        GlobalVar.thread.type1=$scope.articles.length
        return data
    EditorModal $scope
    ThreadViewModel $scope #编辑thread属性用的

.controller 'commonCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles,ThreadViewModel)->    
    $scope.title = GlobalVar.thread.thread_text
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id},(data)->
        $scope.articles=data
        GlobalVar.thread.type0=$scope.articles.length
        return data
    EditorModal $scope
    ThreadViewModel $scope

.controller 'hoverCtrl',($scope,GetArticles,GlobalVar,addDecimal,$location,$ionicLoading,EditorModal,FillScopeArticles,ThreadViewModel)->
    $scope.title = GlobalVar.thread.thread_text
    FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:2},(data)->
        
        data = addDecimal data
        data.sort (a,b)->
            -(a["decimal"] - b["decimal"])
        $scope.articles=data
        GlobalVar.thread.type2=$scope.articles.length
        return data
    EditorModal $scope
    ThreadViewModel $scope

    
