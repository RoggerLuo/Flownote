# 在前面注明所有的依赖,看依赖列表就可以了
require './main-list.css'
module.exports = angular.module('mainlist',[])
.factory 'List',(RemoveFunc,EditorService,DeleteArticle)->
    execute = ($scope)->
        EditorService $scope
        $scope.list={}
        $scope.list.notes=[]
        $scope.list.delete = (note)->
            DeleteArticle(note)
            RemoveFunc.call $scope.list.notes,note
        $scope.list.remove = (note)->
            RemoveFunc.call $scope.list.notes,note
            console.log 'just remove, not delete from server'
        $scope.list.insert=(note)->
            $scope.list.notes.unshift note
        $scope.list.doRefresh = ()->'api'
        $scope.list.showSetRelationModal = $scope.editor.showSetRelationModal
        $scope.list.openEditorModal = $scope.editor.openEditorModal
        $scope.list.showSetClockModal = $scope.editor.showSetClockModal
    execute
.factory 'Lazyload',->
    execute=($scope,lazyloadData,start=0,end=20)->
        if not $scope.list.notes?
            $scope.list.notes=[]
        $scope.list.notes.push.apply($scope.list.notes,lazyloadData.slice(start,end))
        $scope.loadMore = () ->
            start+=20
            end+=20
            $scope.list.notes.push.apply($scope.list.notes,lazyloadData.slice(start,end))
            $scope.$broadcast('scroll.infiniteScrollComplete')
        $scope.moreDataCanBeLoaded=()->
            lazyloadData.length > end        
        # $scope.doRefresh = () ->
        #     $scope.$broadcast('scroll.refreshComplete')

.directive 'indexList', (List)->
    {
        templateUrl:'main-list/index-list-tpl.html'
        restrict: 'EA'
    }
.directive 'mainList', (List)->
    {
        templateUrl:'main-list/list-tpl.html'
        restrict: 'EA'
    }
.factory 'GetArticles',(Resource)->
    (data)->
        thread = ''
        type = '' 
        day=''
        week=''
        month=''
        if data.thread?
            thread = data.thread
        if data.type?
            type = data.type
        if data.day?
            day = data.day
        if data.week?
            week = data.week
        if data.month?
            month = data.month

        Resource.query({method:'get_item',thread_id:thread,type:type,day:day,week:week,month:month}).$promise
.factory 'DecimalFilter',->
    execute = (data)->
        finalData = data.filter (el,index,arr)->
            style = 'button-stable' 
            decimal = 0
            distance = Date.parse(new Date()) - el.remind_time*1000
            decimal = distance
            if distance > 0 
                style = 'button-positive' 
            if distance > 24*60*60*3 
                style = 'button-energized' 
            if distance > 24*60*60*7
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
            if decimal < 1
                # arr.splice index, 1
                return true
            else
                return true
        finalData
    execute

.factory 'addDecimal',->
    execute = (data)->
        data.forEach (el,index,arr)->
            style = 'button-stable' 
            decimal = 0
            distance = Date.parse(new Date()) - el.remind_time*1000
            decimal = distance
            if distance > 0 
                style = 'button-positive' 
            if distance > 24*60*60*3 
                style = 'button-energized' 
            if distance > 24*60*60*7
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
        data
    execute
