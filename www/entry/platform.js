// require("../lib/ionic/css/ionic.css");
// require("../css/style.css");
// //start module
// require('./controllers.js');
// require('./directives.js');
// require('./services.js');
// require('./start.js');
// require('./router.js');

//console.log(angular); 为什么可以在全局空间使用angular，这是什么鬼，是ionic.bundle.js的原因吗

var flownoteModule = require('./flownote-module.js');
flownoteModule .run(function($ionicPlatform) {
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

