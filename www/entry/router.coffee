#不加module.exports angular就找不到 报错，加了就不报错，这是为什么啥，原理还没有搞清楚
module.exports = angular.module('app.router',[])
.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider
      .state 'tab', 
          url: '/tab'
          abstract: true
          templateUrl: 'starter/tabs.html'
        
      .state 'tab.thread', 
          url: '/thread'
          views: 
              'tab-thread': 
                  templateUrl: 'thread/bricks.html'
                  # controller: 'bricksCtrl'
      
      .state 'tab.threadtabs', 
          url: '/threadtabs'
          views: 
              'tab-thread': 
                  templateUrl: 'thread/threadtabs.html'
                  controller: 'DashCtrl'
      
      .state 'tab.threadtabs.common', 
          url: '/common'
          views: 
              'common': 
                   templateUrl: 'thread/dash.html'
                   
      .state 'tab.threadtabs.hover', 
          url: '/hover'
          views: 
              'hover': 
                  templateUrl: 'templates/tab-chats.html'
                  controller: 'ChatsCtrl'





      .state 'tab.chats', 
          url: '/chats'
          views: 
              'tab-chats': 
                  templateUrl: 'templates/tab-chats.html'
                  controller: 'ChatsCtrl'
      
      .state 'tab.chat-detail', 
          url: '/chats/:chatId'
          views: 
              'tab-chats': 
                  templateUrl: 'templates/chat-detail.html'
                  controller: 'ChatDetailCtrl'

      .state 'tab.account', 
          url: '/account'
          views: 
              'tab-account': 
                  templateUrl: 'templates/tab-account.html'
                  controller: 'AccountCtrl'
  
  $urlRouterProvider.otherwise '/tab/thread'
