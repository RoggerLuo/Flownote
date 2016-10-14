#ionic assets
require "../lib/ionic/css/ionic.css"
# require "../css/style.css"
require "../lib/ionic/js/ionic.bundle.min.js"

module.exports = angular.module 'app', [
    'ionic', 
    require('./router.coffee').name, #名字当作依赖，顺便加载
    require('./platform.coffee').name,
    require('./initEvent.coffee').name,
    require('./utils.coffee').name,
    require('./filter.coffee').name,

    # pages controller
    require('../notes/controller.coffee').name,
    require('../retrospect/retrospect.coffee').name,
    require('../setting/setting.coffee').name,

    # components
    require('../main-list/main-list.coffee').name,
    require('../editor/editor.coffee').name,
    require('../thread/thread.coffee').name,
    require('./directives/directives.coffee').name,
    require('./dbModel.coffee').name,

    # require('../calendar/calendar.coffee').name,
    # require('../article/article.coffee').name,

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
