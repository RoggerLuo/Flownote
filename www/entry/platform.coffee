module.exports=angular.module 'app.platform',[]
.run ($ionicPlatform)->
    $ionicPlatform.ready ->
        if window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard
            cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
            cordova.plugins.Keyboard.disableScroll(true);

        if window.StatusBar
            StatusBar.styleDefault()

        #全局禁止touch之后的click事件
        window.addEventListener "touchstart", (e)->
            e.preventDefault()