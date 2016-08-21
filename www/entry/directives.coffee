module.exports = angular.module('app.directives',[])
.directive 'hideTabs', ($rootScope)->
    {
        restrict: 'A'
        link: (scope, element, attributes)->
            scope.$on '$ionicView.beforeEnter', ->
                scope.$watch attributes.hideTabs, (value)->
                    $rootScope.hideTabs = value
            scope.$on '$ionicView.beforeLeave', ->
                $rootScope.hideTabs = false

    }