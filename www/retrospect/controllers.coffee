module.exports = angular.module('retrospect.controller',[])

.controller 'articleSEList', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles,$ionicHistory)-> # 增 
    $ionicHistory.nextViewOptions disableBack: true
    EditorModal $scope
    $scope.title = $stateParams.string
    switch $stateParams.string
        when 'all'
            param={}
        when 'notallocated'
            param={thread:'0',type:'0'}
        when 'rootthread'
            param={thread:'0'}
    
    FillScopeArticles $scope,param,(data)->
        if $stateParams.type is '2' #多一步
            data = DecimalFilter data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
            i=0
            data.forEach (el)->
                if el.decimal>=1
                    i+=1
            GlobalVar.artNum[$stateParams.string] = i # data.length
        else 
            GlobalVar.artNum[$stateParams.string] = data.length        
        return data

.controller 'articleTypeList', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles,$ionicHistory)-> # 增 
    $ionicHistory.nextViewOptions disableBack: true
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
            i=0
            data.forEach (el)->
                if el.decimal>=1
                    i+=1
            GlobalVar.artNum['type'+$stateParams.type] = i # data.length
        else 
            GlobalVar.artNum['type'+$stateParams.type] = data.length        
        return data

.controller 'retrospect', ($scope,GetArticles,GlobalVar,EditorModal)-> 
    EditorModal $scope
    $scope.$on '$ionicView.enter', (e)-> 
        $scope.type0 = GlobalVar.artNum.type0
        $scope.type1 = GlobalVar.artNum.type1
        $scope.type2 = GlobalVar.artNum.type2
        
        $scope.all = GlobalVar.artNum.all
        $scope.notallocated = GlobalVar.artNum.notallocated
        $scope.rootthread = GlobalVar.artNum.rootthread

