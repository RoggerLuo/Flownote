#不加module.exports angular就找不到 报错，加了就不报错，这是为什么啥，原理还没有搞清楚
module.exports = angular.module('app.router',[])
.config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
        .state 'tab', 
            url: '/tab'
            abstract: true
            templateUrl: 'entry/tabs.html'
        
        .state 'tab.retrospect', 
            url: '/retrospect'
            views: 
                'retrospect': 
                    templateUrl: 'retrospect/retrospect.html'
                    controller: 'retrospect'
        
        .state 'tab.setting', 
            url: '/setting'
            views: 
                'setting': 
                    templateUrl: 'setting/setting.html'
                    controller: 'settingCtrl'
        
        .state 'tab.thread-list-editor', 
            url: '/thread-list-editor'
            views: 
                'setting': 
                    templateUrl: 'setting/thread-list.html'
                    controller: 'threadListEditor'
        
        .state 'tab.notes', 
            url: '/notes'
            cache:false
            views: 
                'notes': 
                    templateUrl: 'main-list/index-list-page.html'
                    controller: 'notesCtrl'

        # thread相关页面
        .state 'tab.thread', 
            url: '/thread'
            views: 
                'tab-thread': 
                    templateUrl: 'thread/bricks.html'
                    controller: 'bricksCtrl'
        
        .state 'tab.threadtabs', 
            url: '/threadtabs'
            abstract: true
            cache:false
            views: 
                'tab-thread': 
                    templateUrl: 'thread/threadtabs.html'
        .state 'tab.threadtabs.plan', 
            url: '/plan'
            cache:false
            views: 
                'plan': 
                    templateUrl: 'thread/thread-notes-list.html'
                    controller:'planCtrl'
        .state 'tab.threadtabs.hover', 
            url: '/hover'
            cache:false
            views: 
                'hover': 
                    templateUrl: 'thread/thread-notes-list.html'
                    controller: 'hoverCtrl'
        .state 'tab.threadtabs.common', 
            url: '/common'
            cache:false
            views: 
                'common': 
                    templateUrl: 'thread/thread-notes-list.html'
                    controller: 'commonCtrl'
        
        # ##############
        # # retrospect #
        # ##############

        .state 'tab.noteListByType', 
            url: '/noteListByType/:type' 
            cache:false
            views: 
                'retrospect': 
                    templateUrl: 'main-list/list-page.html'
                    controller: 'noteListByType'
        .state 'tab.noteListByMonth', 
            url: '/noteListByMonth/:month' 
            cache:false
            views: 
                'retrospect': 
                    templateUrl: 'main-list/list-page.html'
                    controller: 'noteListByMonth'


        .state 'tab.noteListSpecial', 
            url: '/noteListSpecial/:string' 
            cache:false
            views: 
                'retrospect': 
                    templateUrl: 'main-list/list-page.html'
                    controller: 'noteListSpecial'                     
                    # templateProvider: ($q)-> 
                    #     return $q (resolve)-> 
                    #         # lazy load the view
                    #         require.ensure ['../main-list/list-page.html'], (require)-> 
                    #             resolve(require('../main-list/list-page.html'))

        # .state('messages.new', {
        #     url: '/new',
        #     templateProvider: ($q) => {
        #         return $q((resolve) => {
        #             # lazy load the view
        #             require.ensure([], () => resolve(require('./views/messages.new.html')));
        #         });
        #     },
        #     controller: 'MessagesNewController as vm',
        #     resolve: {
        #         loadMessagesNewController: ($q, $ocLazyLoad) => {
        #         return $q((resolve) => {
        #             require.ensure([], () => {
        #                 # load only controller module
        #                 let module = require('./controllers/messages.new.controller');
        #                 $ocLazyLoad.load({name: module.name});
        #                 resolve(module.controller);
        #                 })
        #             });
        #         }
        #     }
        # });
        
        ###########
        # Setting #


        #############
        #   notes   #
        #############

    $urlRouterProvider.otherwise '/tab/notes'
