module.exports=angular.module 'article.services',[]
.factory 'TimeKit',->
    require '../starter/timerParser.js'
.factory 'FillScopeArticles',($ionicLoading,GetArticles,ArticleListMethod)->
    execute = ($scope,params,callback='default')->
        ArticleListMethod $scope
        $scope.$on '$ionicView.enter', (e)-> #为了从编辑器后退的时候能够马上捕捉到刚才更新的或者增加的文章
            $ionicLoading.show template: 'Loading...'
            GetArticles(params).then (res)->
                
                if callback isnt 'default'
                    $scope.lazyloadData=callback res.data.reverse()
                else
                    $scope.lazyloadData=res.data.reverse()
                
                #lazyload
                start=0
                end=20
                $scope.articles=[]
                $scope.articles.push.apply($scope.articles,$scope.lazyloadData.slice(start,end) )

                $scope.loadMore = () ->
                    start+=20
                    end+=20
                    $scope.articles.push.apply($scope.articles,$scope.lazyloadData.slice(start,end) )
                    $scope.$broadcast('scroll.infiniteScrollComplete')

                $scope.moreDataCanBeLoaded=()->
                    $scope.lazyloadData.length>end

                $scope.doRefresh = () ->
                    $scope.$broadcast('scroll.refreshComplete')
                #lazyload end


                $ionicLoading.hide()
                console.log 'index get_item成功'
            ,(res)->
                console.log 'index get_item失败'
    execute
.factory 'ArticleListMethod',(RemoveFunc,DeleteArticle,$ionicHistory,$location)->
    execute = ($scope)->
        $scope.remove = (article)-> # 删
            r = confirm "确定要删除"+article.content.slice(0,10)+"?"
            if r
                DeleteArticle(article.item_id)
                RemoveFunc.call $scope.articles,article

        $scope.redirect = (addr)-> #为了日期单位 前后切换的时候不会搞乱返回关系
            $ionicHistory.nextViewOptions disableBack: true
            $location.path addr

    
    execute

.factory 'DecimalFilter',->
    execute = (data)->
        finalData = data.filter (el,index,arr)->
            style = 'button-stable' 
            decimal = 0
            distance = Date.parse(new Date()) - el.remind_time*1000
            if distance > 0 
                decimal = 1
            if distance > 24*60*60*3 
                decimal = 2
            if distance > 24*60*60*7
                decimal = 3
            
            if decimal >= 1
                style = 'button-positive' 
            if decimal >= 2 
                style = 'button-energized' 
            if decimal >= 3
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
            if decimal < 1
                # arr.splice index, 1
                return false
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
            if distance > 0 
                decimal = 1
            if distance > 24*60*60*3 
                decimal = 2
            if distance > 24*60*60*7
                decimal = 3
        
            if decimal >= 1
                style = 'button-positive' 
            if decimal >= 2 
                style = 'button-energized' 
            if decimal >= 3
                style = 'button-assertive'
            arr[index]['buttonStyle'] = style
            arr[index]['decimal'] = decimal
        data
    execute

.factory 'GetArticles',(Resource)->
    (data)->
        thread = ''
        type = '' 
        day=''
        week=''
        if data.thread?
            thread = data.thread
        if data.type?
            type = data.type
        if data.day?
            day = data.day
        if data.week?
            week = data.week
        Resource.query({method:'get_item',thread_id:thread,type:type,day:day,week:week}).$promise
    #     promise.then (res)->
    #         console.log 'get_item成功'
    #     ,(res)->
    #         console.log 'get_item失败'
    # execute


.factory 'DeleteArticle',(Resource)->
    execute=(item_id)->
        item_id=item_id.toString()#转换成字符串
        promise = Resource.query({method:'item_delete',item_id:item_id}).$promise
        promise.then (res)->
            console.log 'DeleteArticle成功'
        ,(res)->
            console.log 'DeleteArticle失败'
    execute
               
.factory 'SaveArticle',(Resource)->
    execute = (content,item_id)->
        item_id=item_id.toString()#转换成字符串        
        promise = Resource.query({method:'item_saveContent',content:content,item_id:item_id}).$promise
        promise.then (res)->
            console.log 'SaveArticle成功'
        ,(res)->
            console.log 'SaveArticle失败'
    execute


.factory 'SetRelation',(Resource)->
    execute = (item_id,thread_id)->
        item_id=item_id.toString()#转换成字符串
        thread_id=thread_id.toString()#转换成字符串
        promise = Resource.query({method:'item_to_thread',thread_id:thread_id,item_id:item_id}).$promise
        promise.then (res)->
            console.log 'SetRelation成功'
        ,(res)->
            console.log 'SetRelation失败'
    execute


.factory 'SetType',(Resource)->
    execute = (item_obj,type)->
        item_id=item_obj.item_id.toString()#转换成字符串
        promise = Resource.query({method:'change_type',item_id:item_id,type:type}).$promise
        promise.then (res)->
            console.log 'SetType成功'
        ,(res)->
            console.log 'SetType失败'
    execute

.factory 'Reclock',(Resource)->
    execute = (item_obj)->
        item_id=item_obj.item_id.toString()#转换成字符串

        seconds=item_obj.remind_time-item_obj.date_and_time
        item_obj.date_and_time=Date.parse(new Date())/1000
        item_obj.remind_time=item_obj.date_and_time+seconds

        promise = Resource.query({method:'refresh_timer',item_id:item_id}).$promise
        promise.then (res)->
            console.log 'Reclock成功'
        ,(res)->
            console.log 'Reclock失败'
    execute


.factory 'SetClock',(Resource)->
    execute = (item_obj,seconds)->
        item_id=item_obj.item_id
        item_obj.remind_time=Date.parse(new Date())/1000 + (seconds-0)
        words=item_obj.remind_text
        promise = Resource.query({method:'set_timer',item_id:item_id,seconds:seconds,words:words}).$promise
        promise.then (res)->
           console.log 'SetClock成功'
        ,(res)->
           console.log 'SetClock失败'
    execute