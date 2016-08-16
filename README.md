####Augest 14th
Build new ionic app : try to learn git, webpack, angular, markdown etc

####Augest 15th 
git pull, fetch, checkout and branch command

####Augest 16th

1. touch之后300ms会自动触发click事件，很诡异
全局禁止touch之后的click事件  
``` javascript
window.addEventListener("touchstart", function(e){
    e.preventDefault();
});
```  


2. angular获取DOM元素
``` javascript
var element=angular.element(document.querySelector('.keyboard-attach'))[0];
```  


3. 就说之前为什么controller只能激活一次，好烦
With the new view caching in Ionic, Controllers are only called
when they are recreated or on app start, instead of every page change.
To listen for when this page is active (for example, to refresh data),
listen for the $ionicView.enter event:
``` javascript
$scope.$on('$ionicView.enter', function(e) {
});
```  


4. 监听键盘
``` javascript
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
```  


5. '$ionicView.beforeEnter'和'$ionicView.beforeLeave'事件
在进入之前赋值，离开之前还原  


6. ui-router不能连续嵌套两个abstact路由
直接把<ion-nav-view>标签换成html代码就可以了  


>directive里面的link是什么？？？？  
>是这样调用根作用域里面的变量的？：  $root.hideTabs，下一步仔细看看directive  
>什么时候在directive里面用watch?  
>以后晚上要提早留出时间总结今天的学习成果  


