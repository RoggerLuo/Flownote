module.exports = angular.module('article.controller',[])
.controller 'threadtabs',($scope,GlobalVar)-> 
    console.log '进入threadtabs'
    $scope.thread_id = GlobalVar.thread_id

.controller 'articleListCtrl',($scope,GetArticles,$stateParams,GlobalVar)-> 
    console.log '进入articleListCtrl'+$stateParams.type+$stateParams.thread_id
    # console.log 'plan:'+$stateParams.thread_id
    # GlobalVar.thread_id=$stateParams.thread_id
    # GetArticles($stateParams.thread_id,1).then (res)->
        # $scope.articles=res.data


.controller 'planCtrl',($scope,GetArticles,$stateParams,GlobalVar)-> 
    console.log '进入planCtrl GlobalVar'+GlobalVar.thread_id
    # console.log 'plan:'+$stateParams.thread_id
    GlobalVar.thread_id=$stateParams.thread_id
    GetArticles($stateParams.thread_id,1).then (res)->
        $scope.articles=res.data

.controller 'hoverCtrl',($scope,GetArticles,$stateParams,GlobalVar)-> 
    console.log '进入hoverCtrl GlobalVar:'+GlobalVar.thread_id
    GetArticles(GlobalVar.thread_id,2).then (res)->
        $scope.articles=res.data

.filter 'switchReminder', ->
    (input)->
        input = input || ''
        output = ''
        timeStr=input

        time_distance=(Date.parse(new Date()) - timeStr)/1000/60/60/24
        hours=new Date(timeStr).getHours()

        days=''
        phase=''
        if  new Date().toLocaleDateString() != new Date( timeStr ).toLocaleDateString() 
            if time_distance>2
                if time_distance>3
                    if time_distance>4
                        if time_distance>5
                            if time_distance>6
                                if time_distance>7
                                    if time_distance>14
                                        if time_distance>21
                                            if time_distance>31
                                                days= '很久前'
                                            else
                                                days= '3周前'
                                            
                                        else
                                            days= '2周前'
                                        
                                    else
                                        days= '1周前'
                                    
                                else
                                    days= '6天前'
                                
                            else
                                days= '5天前'
                            
                        else
                            days= '4天前'
                        
                    else
                        days= '3天前'
                    
                else
                    days= '前天'
                
            else
                days= '昨天'
            
        else
            days= '今天'
        

        if hours>=1
            if hours>=6
                if hours>=8
                    if hours>=11
                        if hours>=14 #//大于等于才行
                            if hours>=18
                                if hours>=23
                                    phase= '深夜'
                                else
                                    phase= '晚上'
                                
                            else
                                phase= '下午'
                            
                        else
                            phase= '中午'
                        
                    else
                        phase= '上午'
                    
                else
                    phase= '清晨'
                
            else
                phase= '凌晨'
            
        else
            phase= '凌晨1点前后'
        
        # // return days+'的'+phase
        output=days
        output
    
