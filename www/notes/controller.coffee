module.exports = angular.module('notes.controller',[])
.controller 'notesCtrl', ($scope,List,Db,Lazyload,addDecimal)-> 
    List $scope
    $scope.editor.onSetRelationEnd = $scope.list.remove
    $scope.editor.onSetPlanEnd = $scope.list.remove
    $scope.editor.onSetClockEnd = $scope.list.remove
    $scope.editor.onCreateEnd = $scope.list.insert

    $scope.refresh = ->
        notes = []
        notesPart1 = Db.items.query({type:'0'}).reverse()
        notesPart2 = Db.items.query({type:'2',ready:true}).sort (a,b)->
                -(a["remind_time"] - b["remind_time"])
        notesPart3 = Db.items.query({type:'1'}).reverse()
        notes = notesPart1.concat(notesPart2).concat(notesPart3)
        
        # if notes.length == 0
        #     notes=[{content:'暂时没有需要处理的文档',date_and_time:Date.parse(new Date())/1000}]
        
        $scope.list.notes=[]
        Lazyload $scope,notes
    
    $scope.doRefresh = () ->
        $scope.refresh()
        $scope.$broadcast('scroll.refreshComplete')

    $scope.$on '$ionicView.enter', (e)-> 
        $scope.refresh()

    $scope.$on 'DbInitComplete',(e)->                        
        $scope.refresh()

# .controller 'planCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles,ThreadViewModel)->
#     $scope.title = GlobalVar.thread.thread_text
#     FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:1},(data)->
#         $scope.articles=data
#         GlobalVar.thread.type1=$scope.articles.length
#         return data
#     EditorModal $scope
#     ThreadViewModel $scope #编辑thread属性用的

# .controller 'commonCtrl',($scope,GlobalVar,EditorModal,FillScopeArticles,ThreadViewModel)->    
#     $scope.title = GlobalVar.thread.thread_text
#     FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id},(data)->
#         $scope.articles=data
#         GlobalVar.thread.type0=$scope.articles.length
#         return data
#     EditorModal $scope
#     ThreadViewModel $scope

# .controller 'hoverCtrl',($scope,GetArticles,GlobalVar,addDecimal,$location,$ionicLoading,EditorModal,FillScopeArticles,ThreadViewModel)->
#     $scope.title = GlobalVar.thread.thread_text
#     FillScopeArticles $scope,{thread:GlobalVar.thread.thread_id,type:2},(data)->
        
#         data = addDecimal data
#         data.sort (a,b)->
#             -(a["decimal"] - b["decimal"])
#         $scope.articles=data
#         GlobalVar.thread.type2=$scope.articles.length
#         return data
#     EditorModal $scope
#     ThreadViewModel $scope

    
