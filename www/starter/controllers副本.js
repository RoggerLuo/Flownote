var controller=angular.module('starter.controllers', [])
/*
  不用加载angular ionicbundle里面就有了
  主要是这个controller和tpl
*/
.controller('AccountCtrl', function($scope) {
    // 监听键盘事件
    window.addEventListener('native.keyboardshow', keyboardShowHandler);
    window.addEventListener('native.keyboardhide', keyboardHideHandler);
    function keyboardHideHandler(e){
        $scope.show=false;
    }
    function keyboardShowHandler(e){
        $scope.show=true;
    }
    $scope.stopPro = function($event){
        cordova.plugins.Keyboard.close();//关键盘
    };
    $scope.show=true;
})


.controller('DashCtrl', function($scope){})

.controller('ChatsCtrl', function($scope, Chats) {
  $scope.chats = Chats.all();
  $scope.remove = function(chat) {
    Chats.remove(chat);
  };
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})

module.exports=testv;
// module.exports=controller;