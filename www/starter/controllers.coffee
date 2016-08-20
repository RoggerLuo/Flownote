module.exports = angular.module('starter.controller',[])

.controller 'calendarMonth',($scope,GetArticles,GlobalVar,$location,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true

    now = new Date() #当前日期 2016
    nowMonth = now.getMonth()+1 #当前月 
    MonthArr = while nowMonth>0
        nowMonth--
    $scope.months = MonthArr
    $scope.redirect = (addr)->
        $location.path addr

.controller 'calendarWeek',($scope,$stateParams,GetArticles,GlobalVar,$location,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true
    timer = require './timerParser.js'

    # 处理参数，week获得一个月份，然后展示这个月份的 weeks
    if $stateParams.month==''
        thistime = new Date()
        nowMonthRealWorld = thistime.getMonth()+1 #为了给 month设定一个默认值
    else
        nowMonthRealWorld = $stateParams.month 
    
    nowMonth = nowMonthRealWorld - 1 #机器识别的month比现实生活中的month小1，容易搞错
    
    monthStartDate = timer.getCertainMonthStartDate nowMonth
    monthEndDate = timer.getCertainMonthEndDate nowMonth
    
    firstWeek = timer.getCertainWeekStartDate(monthStartDate[0]) #第一周的第一天
    firstWeekNum = timer.getYearWeek(monthStartDate[0])#这个月第一周的 周数
    lastWeekNum = timer.getYearWeek(monthEndDate[0])#这个月最后一周的 周数

    i = firstWeekNum 
    weekArr = while i<=lastWeekNum
        {
            weekNum:i++
            startDate:timer.dateAdd firstWeek,(i-firstWeekNum)*7
            endDate:timer.dateAdd firstWeek ,6+ (i-firstWeekNum)*7
        }

    $scope.weeks = weekArr.filter (el)->
        Date.parse(new Date()) >= Date.parse(new Date(el.startDate))
    .reverse()
    $scope.redirect = (addr)->
        $location.path addr

.controller 'calendarDay',($scope,GetArticles,GlobalVar,$stateParams,$location,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true

    timer = require './timerParser.js'     

    # 处理参数
    if $stateParams.week==''
        now = new Date() #当前日期         
        data = timer.wholeWeek(now).filter (el)->
            Date.parse(now) >= Date.parse(new Date(el.date))
        $scope.days = data.reverse()

    else
        now = new Date($stateParams.week) #传入这个星期的第一天
        $scope.days = timer.wholeWeek(now).reverse()

    $scope.redirect = (addr)->
        $location.path addr

.controller 'editorCtrl', ($scope)->
    #监听键盘事件
    window.addEventListener 'native.keyboardshow', keyboardShowHandler
    window.addEventListener 'native.keyboardhide', keyboardHideHandler
    keyboardHideHandler = (e) ->
        $scope.show = false
    
    keyboardShowHandler = (e) ->
        $scope.show = true
    
    $scope.stopPro = ($event)->
        cordova.plugins.Keyboard.close() #关键盘
    
    $scope.show = true

