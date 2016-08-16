var angular= require('angular');

var controller=angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope) {})

.controller('ChatsCtrl', function($scope, Chats) {
  $scope.chats = Chats.all();
  $scope.remove = function(chat) {
    Chats.remove(chat);
  };
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})

.controller('AccountCtrl', function($scope) {
    // 监听键盘事件
    window.addEventListener('native.keyboardshow', keyboardShowHandler);
    window.addEventListener('native.keyboardhide', keyboardHideHandler);
    $scope.show=true;
    function keyboardHideHandler(e){
        $scope.show=false;
    }
    function keyboardShowHandler(e){
        $scope.show=true;
    }

    //关键盘
    cordova.plugins.Keyboard.close();
    
    $scope.settings = {
        enableFriends: true
    };

    $scope.stopPro = function($event){
        cordova.plugins.Keyboard.close();
    };
});

module.exports=controller;