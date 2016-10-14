module.exports=angular.module 'article.services',[]
.factory 'ListOperation',(RemoveFunc)->
    # 先设置checkMatch,注意有两个参数
    # 再trigger
    return {
        remove:{
            thread:''
            type:''
            trigger:($scope,article,thread = '0',type = '0',oprt = '')->
                if not this.checkMatch(thread,type,oprt)
                    this.remove($scope,article)
            checkMatch:->
                true
            remove:($scope,article)->
                RemoveFunc.call $scope.articles,article
        }
    }

.factory 'FillScopeArticles',($ionicLoading,ArticleListMethod,GetArtListWithLazy)->
    execute = ($scope,params,callback='default')->
        ArticleListMethod $scope
        $scope.$on '$ionicView.enter', (e)-> #为了从编辑器后退的时候能够马上捕捉到刚才更新的或者增加的文章
            GetArtListWithLazy $scope,params,callback
    execute

.factory 'GetArtListWithLazy',(GetArticles,Lazyload,DecimalFilter)->
    execute=($scope,params,callback)->
        GetArticles(params).then (res)->
            if callback isnt 'default'
                lazyloadData=callback res.data.reverse()
            else
                lazyloadData=res.data.reverse()
            lazyloadData = DecimalFilter lazyloadData
            Lazyload $scope,lazyloadData
            console.log 'index get_item成功'
        ,(res)->
            console.log 'index get_item失败'
    execute    
.factory 'Lazyload',->
    execute=($scope,lazyloadData,start=0,end=20)->
        $scope.articles=[]
        $scope.articles.push.apply($scope.articles,lazyloadData.slice(start,end))
        $scope.loadMore = () ->
            start+=20
            end+=20
            $scope.articles.push.apply($scope.articles,lazyloadData.slice(start,end))
            $scope.$broadcast('scroll.infiniteScrollComplete')
        $scope.moreDataCanBeLoaded=()->
            lazyloadData.length > end
        $scope.doRefresh = () ->
            $scope.$broadcast('scroll.refreshComplete')
    execute
.factory 'ArticleListMethod',(RemoveFunc,DeleteArticle,$ionicHistory,$location)->
    execute = ($scope)->
        $scope.remove = (article)-> # 删
            # r = confirm "确定要删除"+article.content.slice(0,10)+"?"
            # if r
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
        # promise.then (res)->
        #     console.log 'SaveArticle成功'
        # ,(res)->
        #     console.log 'SaveArticle失败'
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

