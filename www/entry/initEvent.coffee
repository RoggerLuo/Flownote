module.exports=angular.module 'app.initEvent',[]
.run ($rootScope,ThreadsHandler,GetArticles,Db)-> # 加载 thread数据
    ThreadsHandler (data)->
        # true
        GetArticles({}).then (res)->
            Db.items.load(res.data)
            $rootScope.$broadcast('DbInitComplete')
