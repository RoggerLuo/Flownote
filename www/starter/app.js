// require("../lib/ionic/css/ionic.css");
// require("../css/style.css");
// //start module
// require('./controllers.js');
// require('./directives.js');
// require('./services.js');
// require('./start.js');

require('./router.js');
require('./platform.js');

//console.log(angular); 为什么可以在全局空间使用angular，这是什么鬼，是ionic.bundle.js的原因吗

var angular=require("./ng.js");
angular.module('flownote', ['ionic', 'starter.controllers','starter.services','directives'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)

    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }

    //全局禁止touch之后的click事件
    window.addEventListener("touchstart", function(e){
        e.preventDefault();
    });

  });
})

module.exports = angular;
