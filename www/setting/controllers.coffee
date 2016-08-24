module.exports = angular.module('setting.controller',[])
.controller 'settingCtrl', ($scope,$stateParams,GetArticles,$ionicHistory,GlobalVar,$location,DeleteArticle,RemoveFunc,$ionicLoading)-> # 增 
    $scope.$on '$ionicView.enter', (e)-> 
        $scope.type0 = GlobalVar.number.type0
        $scope.type1 = GlobalVar.number.type1
        $scope.type2 = GlobalVar.number.type2

.controller 'dataArticleList', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles)-> # 增 
    EditorModal $scope
    
    mapping = {
        '0' : 'Raw'
        '1' : 'Plan'
        '2' : 'Hover'
    }
    
    $scope.title = mapping[$stateParams.type]
    
    # list data
    FillScopeArticles $scope,type:$stateParams.type,(data)->
        if $stateParams.type is '2' #多一步
            data = DecimalFilter data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
        GlobalVar.number['type'+$stateParams.type] = data.length
        return data
