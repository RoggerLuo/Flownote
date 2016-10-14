module.exports = angular.module('setting.controller',[])
.controller 'settingCtrl', ($scope,Resource,$stateParams,Db,GetArticles,$ionicHistory,GlobalVar,$location,DeleteArticle,RemoveFunc,$ionicLoading,$rootScope)-> # 增 
    $scope.rawToggleTrigger = ->
        GlobalVar.rawFilter = !GlobalVar.rawFilter
    $scope.summaryToggleTrigger = ->
        GlobalVar.summaryFilter = !GlobalVar.summaryFilter

    lastTime = 0
    
    getChart =(data)->
        labels = []
        data_value=[]
        i = 0
        
        for key, el of data
             labels.unshift(key)
             data_value.unshift(el)

        j= labels.length - 1
        while j >= 0
             j--
             # if i!=0
             #     labels[j]='';                            
             # i=i+1;                            
             # if i==7
             #     i=0;
             dt = new Date('2016-'+labels[j])
             dt2 = new Date()
             # weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
             weekDay = ["星期天", "", "", "", "", "", ""];
             labels[j]=weekDay[dt.getDay()]  

        ctx=document.getElementById("operation-chart")
        myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '',
                    data: data_value,
                    borderColor: "rgb(81, 182, 212)",

                    backgroundColor: "rgb(204, 241, 252)",
                    # // borderColor: "white",

                    borderWidth: 0.5,
                    pointBorderColor:'white',
                    pointBackgroundColor:'rgb(138, 220, 245)',
                    pointBorderWidth:1,
                }]
            },
            options: {
                legend:{
                    display:false
                },
                scales: {
                    xAxes: [{
                        # // display: false
                        gridLines:{
                            display:false
                        }
                    }], 
                    yAxes: [{
                        display: false
                    }]
                }
            }
        })
    refresh=->
        promise = Resource.query({method:'single_line_chart'}).$promise
        promise.then (res)->
            console.log 'single_line_chart成功'
            data = res.data
            getChart(data)
        ,(res)->
           console.log 'single_line_chart失败'

    $scope.$on '$ionicView.enter', (e)-> 
        if (Date.parse(new Date()) - lastTime) >= 60*60*1000
            refresh()
            lastTime = Date.parse(new Date())

    $scope.sync=()->
        GetArticles({}).then (res)->
            Db.items.load(res.data)
            $rootScope.$broadcast('DbInitComplete')
