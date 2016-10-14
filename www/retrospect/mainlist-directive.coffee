module.exports = angular.module('directive.mainlist',[])
.directive 'mainList', (Db,RemoveFunc,DeleteArticle)->
    {
        restrict: 'EA'
        link: (scope, element, attributes)->
            scope.list={}
            scope.list.load(articles)->
                scope.articles = articles
            scope.list.remove(article)->
                DeleteArticle(article.item_id)
                RemoveFunc.call scope.articles,article
            scope.list.insert(item)->
                scope.articles.push item
    }


# controller

# refresh = ->
#     articles = []
#     articlesPart1 = Db.items.query({thread:'0',type:'0'}).reverse()
#     articlesPart2 = Db.items.query({type:'2',ready:true}).sort (a,b)->
#             -(a["remind_time"] - b["remind_time"])
#     articles = articlesPart1.concat articlesPart2
#     $scope.list.load articles
