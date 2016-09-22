module.exports = angular.module('retrospect.controller',[])

.controller 'articleSEList', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles,$ionicHistory,ListOperation)-> # 增 
    $ionicHistory.nextViewOptions disableBack: true
    EditorModal $scope
    $scope.title = $stateParams.string
    switch $stateParams.string
        when 'All'
            param={}
        when 'Untreated'
            param={thread:'0',type:'0'}
            ListOperation.remove.checkMatch=(thread,type)->
                (thread == '0') && (type == '0')

        when 'Uncategorized'
            param={thread:'0'}
            ListOperation.remove.checkMatch=(thread)->
                thread == '0'

    
    FillScopeArticles $scope,param,(data)->
        if $stateParams.type is '2' #多一步
            data = DecimalFilter data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
        return data

.controller 'articleTypeList', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles,$ionicHistory,ListOperation)-> # 增 
    $ionicHistory.nextViewOptions disableBack: true
    EditorModal $scope
    mapping = {
        '0' : 'Raw'
        '1' : 'Plan'
        '2' : 'Hover'
    }
    $scope.title = mapping[$stateParams.type]
    ListOperation.remove.checkMatch=(thread,type,oprt)->
        if type == $stateParams.type
            if type == '2'
                if oprt == 'setPeriod'
                    # 重新计算提醒时间，重新排序
                    $scope.articles = DecimalFilter $scope.articles
                    $scope.articles.sort (a,b)->
                        -(a["decimal"] - b["decimal"])
                    return true
            else 
                return true

    # list data
    FillScopeArticles $scope,type:$stateParams.type,(data)->
        if $stateParams.type is '2' #多一步
            data = DecimalFilter data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
        return data

.controller 'articleByMonth', ($scope,$stateParams,GetArticles,GlobalVar,DecimalFilter,EditorModal,FillScopeArticles,$ionicHistory)-> # 增 
    $ionicHistory.nextViewOptions disableBack: true
    EditorModal $scope
    FillScopeArticles $scope,month:$stateParams.month


.controller 'retrospect', ($scope,DecimalFilter,GetArticles,GlobalVar,EditorModal,GetArtNumOfMonth,FillScopeArticles,GetArtNumOfCate)->     
    EditorModal $scope

    $scope.$on '$ionicView.enter', (e)-> 
        finalArray = []
        param1={thread:'0',type:'0'}
        GetArticles(param1).then (res)->
            finalArray=DecimalFilter(res.data.reverse())
            param2={type:'2'}
            GetArticles(param2)
        .then (res)->
            data = DecimalFilter res.data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
            finalData = data.filter (el)->
                el.decimal>=0
            $scope.articles=finalArray.concat(finalData);

        # 获得每个分类的文章数量
        GetArtNumOfMonth().then (res)->
            res.data.forEach (el,index,arr)->
                Ym = el.date.substring(el.date.length-2)
                arr[index].date = Ym
            $scope.months = res.data
        GetArtNumOfCate().then (res)->
            mapping = ['all','untreated','uncategorized','raw','plan','hover']
            $scope.articleNumber={}
            mapping.forEach (el)->
                $scope.articleNumber[el]=res.data[el]

    