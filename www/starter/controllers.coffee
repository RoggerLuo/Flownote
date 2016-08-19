module.exports = angular.module('starter.controller',[])
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

.controller 'DashCtrl', ($scope)->
    true

.controller 'ChatsCtrl', ($scope, Chats)->
    $scope.chats = Chats.all()
    $scope.remove = (chat) ->
        Chats.remove chat
    
.controller 'ChatDetailCtrl', ($scope, $stateParams, Chats)->
    $scope.chat = Chats.get $stateParams.chatId
    
