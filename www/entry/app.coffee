#ionic assets
require "../lib/ionic/css/ionic.css"
require "../css/style.css"
require "../lib/ionic/js/ionic.bundle.js"

module.exports = angular.module 'app', [
    'ionic', 
    require('./router.coffee').name, #名字当作依赖，顺便加载
    require('./platform.coffee').name,
    require('./filter.coffee').name,
    require('../directives/directives.coffee').name,
    require('../article/article.coffee').name,
    require('../thread/thread.coffee').name,
    require('../starter/starter.coffee').name,
    require('../editor/editor.coffee').name
    ]

#entry
#require './router.coffee'
#require './platform.js'
#require './directives.js'

#starter
#require '../starter/controllers.js'
#require '../starter/services.js'

#thread
#require '../thread/controllers.coffee'
#require '../thread/services.coffee'

#console.log(angular); 为什么可以在全局空间使用angular，这是什么鬼，是ionic.bundle.js的原因吗
