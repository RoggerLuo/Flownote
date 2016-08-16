**Augest 14th**
: Build new ionic app : try to learn git, webpack, angular, markdown etc

**Augest 15th** 
: git pull, fetch, checkout and branch command

**Augest 16th**
touch之后300ms会自动触发click事件，很诡异
全局禁止touch之后的click事件
``` javascript
window.addEventListener("touchstart", function(e){
    e.preventDefault();
});
```
angular获取DOM元素
``` javascript
var element=angular.element(document.querySelector('.keyboard-attach'))[0];
```