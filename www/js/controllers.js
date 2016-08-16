var angular= require('angular');

var controller=angular.module('starter.controllers', [])


.controller('DashCtrl', function($scope) {})

.controller('ChatsCtrl', function($scope, Chats) {
  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //
  //$scope.$on('$ionicView.enter', function(e) {
  //});

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

    

    //为了避免延迟触发的click事件  //阻止点击到textarea上
    // var element=angular.element(document.querySelector('.keyboard-attach'))[0];
    // element.addEventListener("touchstart", function(e){
    //     e.preventDefault();
    // });

    $scope.settings = {
        enableFriends: true
    };

    $scope.stopPro = function($event){
        cordova.plugins.Keyboard.close();
    };
    // angular.element(document.querySelector('textarea'))[0].focus();

});

module.exports=controller;