module.exports = angular.module('setting.controller',[])
.controller 'settingCtrl', ($scope,$stateParams,GetArticles,$ionicHistory,GlobalVar,$location,DeleteArticle,RemoveFunc,$ionicLoading)-> # 增 
    
    $scope.rawToggleTrigger = ->
        GlobalVar.rawFilter = !GlobalVar.rawFilter
    $scope.summaryToggleTrigger = ->
        GlobalVar.summaryFilter = !GlobalVar.summaryFilter




