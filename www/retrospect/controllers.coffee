module.exports = angular.module('retrospect.controller',[])
.controller 'retrospect', ($scope,Db,EditorService,GetArtNumOfMonth,GetArtNumOfCate)->     
    EditorService $scope
    $scope.refresh = ->
        console.log '获得每个分类的文章数量'
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

    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')
    
    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()

.controller 'noteListByType', ($scope,Db,$stateParams,Lazyload,DecimalFilter,$ionicHistory,List)->
    $ionicHistory.nextViewOptions disableBack: true
    List $scope
    mapping = {
        '0' : '笔记'
        '1' : '计划'
        '2' : '提醒'
    }
    $scope.title = mapping[$stateParams.type]
    
    $scope.refresh = ->
        console.log '刷新noteListByType'
        notes = Db.items.query({type:$stateParams.type}).reverse()
        if $stateParams.type is '2' 
            notes = DecimalFilter notes
            notes.sort (a,b)->
                -(a["decimal"] - b["decimal"])
        $scope.list.notes=[]
        Lazyload $scope,notes

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()

    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

.controller 'noteListSpecial', ($scope,Db,List,Lazyload,$stateParams,DecimalFilter,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true
    List $scope
    mapping = {
        'All' : '所有'
        'Untreated' : '未处理'
        'Uncategorized' : '未分类'
    }
    $scope.title = mapping[$stateParams.string]

    $scope.refresh = ->
        console.log '刷新noteListByType'
        notes=[]
        switch $stateParams.string
            when 'All'
                notes = Db.items.query({}).reverse()
                notes = DecimalFilter notes
            when 'Untreated'
                param={thread:'0',type:'0'}
                notes = Db.items.query(param).reverse()
                $scope.editor.onSetRelationEnd = $scope.list.remove
                $scope.editor.onSetPlanEnd = $scope.list.remove
                $scope.editor.onSetClockEnd = $scope.list.remove
            when 'Uncategorized'
                param={thread:'0'}
                notes = Db.items.query(param).reverse()
                notes = DecimalFilter notes
                $scope.editor.onSetRelationEnd = $scope.list.remove
        # if $stateParams.type is '2' #多一步
        #     notes = DecimalFilter notes
        #     notes.sort (a,b)->
        #         -(a["decimal"] - b["decimal"])
        $scope.list.notes=[]
        Lazyload $scope,notes

    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()

.controller 'noteListByMonth', ($scope,Db,List,Lazyload,$stateParams,DecimalFilter,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true
    List $scope
    $scope.title = $stateParams.month + '月'
    $scope.refresh = ->
        console.log '刷新noteListByMonth'
        notes = Db.items.query({month:$stateParams.month}).reverse()
        $scope.editor.onSetRelationEnd = $scope.list.remove
        $scope.editor.onSetPlanEnd = $scope.list.remove
        $scope.editor.onSetClockEnd = $scope.list.remove
        $scope.list.notes=[]
        Lazyload $scope,notes

    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()    



# ListOperation.remove.checkMatch=(thread,type,oprt)-> #if not match then remove
#     if type == $stateParams.type
#         if type == '2'
#             if oprt == 'setPeriod'
#                 # 重新计算提醒时间，重新排序
#                 $scope.articles = DecimalFilter $scope.articles
#                 $scope.articles.sort (a,b)->
#                     -(a["decimal"] - b["decimal"])
#                 return true
#         else 
#             return true


# refresh = ->
#     console.log 'refresh'
#     finalArray = []
#     param1={thread:'0',type:'0'}
    
#     GetArticles(param1).then (res)->
#         finalArray=DecimalFilter(res.data.reverse())
#         param2={type:'2'}
#         GetArticles(param2)
#     .then (res)->
#         data = DecimalFilter res.data
#         data.sort (a,b)->
#             -(a["decimal"] - b["decimal"])
#         finalData = data.filter (el)->
#             el.decimal>=0
#         $scope.articles=finalArray.concat(finalData);

# lastTime = 0

# setInterval(()->
#     console.log 'pollingRefresh'
#     console.log(Date.parse(new Date()) - lastTime)
#     if (Date.parse(new Date()) - lastTime) >= 60*10*1000
#         refresh()
#         lastTime = Date.parse(new Date())
# , 600000); 

# $scope.showPopupAgent=(article)->
#     $scope.showPopup(article)

