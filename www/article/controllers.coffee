module.exports = angular.module('article.controller',[])

.controller 'planCtrl',($scope,GetArticles,GlobalVar,$ionicLoading)-> 
    $scope.$on '$ionicView.enter', (e)->
        $ionicLoading.show template: 'Loading...'
        GetArticles(GlobalVar.thread_id,1).then (res)->
            $scope.articles=res.data
            $ionicLoading.hide()

.controller 'hoverCtrl',($scope,GetArticles,GlobalVar,addDecimal,$location,$ionicModal,$ionicLoading)-> 
    $scope.$on '$ionicView.enter', (e)->
        $ionicLoading.show template: 'Loading...'
        GetArticles(GlobalVar.thread_id,2).then (res)->
            data = addDecimal res.data
            data.sort (a,b)->
                -(a["decimal"] - b["decimal"])
            $scope.articles = data
            $ionicLoading.hide()

    # /* ionicModal */
    $ionicModal.fromTemplateUrl 'article/editor-modal.html', {
        scope: $scope,
        animation: 'slide-in-up'
    }
    .then (modal) ->
        $scope.modal = modal
    
    $scope.openModal = (article) ->
        $scope.modal.show()
        $scope.article = article
    $scope.closeModal = ->
        $scope.modal.hide()
    # Cleanup the modal when we're done with it!
    $scope.$on '$destroy', ->
        $scope.modal.remove()
    # Execute action on hide modal
    $scope.$on 'modal.hidden', ->
        # Execute action
    # Execute action on remove modal
    $scope.$on 'modal.removed', ->
        # Execute action

.controller 'commonCtrl',($scope,GetArticles,GlobalVar)-> 
    $scope.$on '$ionicView.enter', (e)->
        GetArticles(GlobalVar.thread_id,0).then (res)->
            $scope.articles=res.data

.filter 'TimestampToHour', ->
    (input)->
        if input < 1008122669
            input = 1451577600
        now = new Date(input*1000)
        now.getHours() + ':' + now.getMinutes() 
.filter 'interpretTimestamp', ->
    (input)->
        if input < 1008122669
            input = 1451577600
        now = new Date(input*1000)
        myyear = now.getFullYear()
        mymonth = now.getMonth()+1 
        myweekday = now.getDate() 
        hour = now.getHours() 
        min = now.getMinutes() 
        if hour < 10
            hour = "0" + hour
        
        if min < 10
            min = "0" + min 
        
        myyear + "年" + mymonth + "月" + myweekday + '日 ' + hour + ':' + min


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
                        if hours>=14 ##大于等于才行
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
        
        # # return days+'的'+phase
        output=days
        output
    
