module.exports = angular.module('starter.controller',[])
.controller 'newCtrl', ($scope,CreateArticle)-> # 增 
    window.addEventListener('native.keyboardshow', keyboardShowHandler)
    window.addEventListener('native.keyboardhide', keyboardHideHandler)
    keyboardHideHandler = (e)->
        $scope.show = false
    keyboardShowHandler = (e)->
        $scope.show = true
    $scope.stopPro = ($event)->
        cordova.plugins.Keyboard.close()
    $scope.show = true
    article = {
        content:''
        item_id:'new'
        remind_time:'0'
        remind_text:''
        type:'0'
        thread_id:'0'
    }
    $scope.article = article
    $scope.$on "$ionicView.beforeLeave", (event, data)-> #为了后退的时候能够保存
        if article.content isnt ""
            CreateArticle(article.content)

.controller 'editorCtrl', ($scope,GlobalVar,SaveArticle)-> # 改 
    window.addEventListener('native.keyboardshow', keyboardShowHandler)
    window.addEventListener('native.keyboardhide', keyboardHideHandler)
    keyboardHideHandler = (e)->
        $scope.show = false
    keyboardShowHandler = (e)->
        $scope.show = true
    $scope.stopPro = ($event)->
        cordova.plugins.Keyboard.close()
    $scope.show = true
    $scope.article = GlobalVar.article
    originContent = $scope.article.content
    
    $scope.$on "$ionicView.beforeLeave", (event, data)-> #为了后退的时候能够保存
        if $scope.article.content isnt originContent
            SaveArticle($scope.article.content,$scope.article.item_id)

.controller 'articleListByDay',($scope,$stateParams,GetArticles,$ionicHistory,GlobalVar,$location,DeleteArticle,RemoveFunc)->
    $scope.$on '$ionicView.enter', (e)-> #为了从编辑器后退的时候能够马上捕捉到刚才更新的或者增加的文章
        GetArticles(day:$stateParams.day).then (res)->
            $scope.articles=res.data.reverse()
            console.log 'index get_item成功'
        ,(res)->
            console.log 'index get_item失败'

    timer = require './timerParser.js'     
    $scope.dateInChinese =  timer.textToChinese($stateParams.day)#当前日期,传入当前 时间会错，有时候浏览器的时区不对，###统一传入text###
    $scope.redirectWithArticle = (article)->
        GlobalVar.article = article
        $location.path 'tab/editor'
    $scope.redirectWithHistory = (addr)-> # 为了新建编辑页的 返回功能 保存历史
        $location.path addr
    $scope.remove = (article)-> # 删
        r = confirm "确定要删除"+article.content.slice(0,10)+"?"
        if r
            DeleteArticle(article.item_id)
            RemoveFunc.call $scope.articles,article

.controller 'calendarDay',($scope,GetArticles,GlobalVar,$stateParams,$location,$ionicHistory)->
    timer = require './timerParser.js'     
    now = timer.getNowDate() #当前时间yyyy-mm-dd, 传入当前时间会错，有时候时区不对，统一传入不带小时的日期
    # 处理参数
    if $stateParams.week==''
        weekstart = now 
    else
        weekstart = $stateParams.week #传入这个星期的第一天   
    weekArr = timer.wholeWeek(weekstart).filter (el)-> #统一传入text
        Date.parse(now) >= Date.parse(new Date(el.date))
    .reverse()

    $scope.days = weekArr
    $scope.redirect = (addr)-> #为了日期单位 前后切换的时候不会搞乱返回关系
        $ionicHistory.nextViewOptions disableBack: true
        $location.path addr
    $scope.redirectWithHistory = (addr)-> # 为了新建编辑页的 返回功能 保存历史
        $location.path addr
    $scope.redirectWithArticle = (article)->
        GlobalVar.article = article
        $location.path 'tab/editor'

    #article
    weekStart = timer.getCertainWeekStartDate(now) #获取这周起始日期 
    GetArticles(week:weekStart).then (res)->
        $scope.articles=res.data.reverse()
        console.log 'index get_item成功'
    ,(res)->
        console.log 'index get_item失败'


.controller 'calendarMonth',($scope,GetArticles,GlobalVar,$location,$ionicHistory)->
    $ionicHistory.nextViewOptions disableBack: true

    now = new Date() #当前日期 2016
    nowMonth = now.getMonth()+1 #当前月 
    MonthArr = while nowMonth>0
        nowMonth--
    $scope.months = MonthArr
    $scope.redirect = (addr)->
        $location.path addr
    $scope.redirectWithHistory = (addr)-> # 为了新建编辑页的 返回功能 保存历史
        $location.path addr


.controller 'calendarWeek',($scope,$stateParams,GetArticles,GlobalVar,$location,$ionicHistory)->
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

    now = timer.getNowDate()#当前日期,传入当前 时间会错，有时候浏览器的时区不对，###统一传入text###
    data = weekArr.filter (el)->
        Date.parse(new Date(now)) >= Date.parse(new Date(el.startDate))
    .reverse()
    $scope.weeks = data
    $scope.redirect = (addr)->
        $ionicHistory.nextViewOptions disableBack: true
        $location.path addr
    $scope.redirectWithHistory = (addr)-> # 为了新建编辑页的 返回功能 保存历史
        $location.path addr


