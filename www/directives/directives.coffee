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

.directive 'editorFooter', ->
    {
        restrict: 'EA'
        templateUrl:'directives/editor-footer.html'
        controller: ($scope, $element,EditorFunction)->
            EditorFunction $scope
    }

.directive 'keyboardAttachment', ->
    {
        restrict: 'EA'
        templateUrl:'directives/keyboard-attachment.html'
        controller: ($scope, $element)->
            $scope.stopPro = ($event)->
                cordova.plugins.Keyboard.close()
            $scope.show = true
    }
.directive 'keyboardAttachmentse', ->
    {
        restrict: 'EA'
        templateUrl:'directives/keyboard-attachment-se.html'
        controller: ($scope, $element)->
            element=document.querySelector('.keyboard-attachse')
            element.addEventListener "touchstart", (e)->
                e.preventDefault()
            # window.addEventListener('native.keyboardshow', keyboardShowHandler)
            # window.addEventListener('native.keyboardhide', keyboardHideHandler)
            # keyboardHideHandler = (e)->
            #     $scope.show = false
            # keyboardShowHandler = (e)->
            #     $scope.show = true
            $scope.stopKP = ($event)->
                cordova.plugins.Keyboard.close()
            $scope.showSE = true
    }