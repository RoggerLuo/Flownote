module.exports = angular.module('editor.controller',[])

# .controller 'newCtrl', ($scope,CreateArticle,EditorThreadModal)-> # 增 
#     element=document.querySelector('.keyboard-attach')
#     element.addEventListener "touchstart", (e)->
#         e.preventDefault()
#     window.addEventListener('native.keyboardshow', keyboardShowHandler)
#     window.addEventListener('native.keyboardhide', keyboardHideHandler)
#     keyboardHideHandler = (e)->
#         $scope.show = false
#     keyboardShowHandler = (e)->
#         $scope.show = true
#     $scope.stopPro = ($event)->
#         cordova.plugins.Keyboard.close()
#     $scope.show = true
#     article = {
#         content:''
#         item_id:'new'
#         remind_time:'0'
#         remind_text:''
#         type:'0'
#         thread_id:'0'
#     }
#     $scope.article = article
#     $scope.$on "$ionicView.beforeLeave", (event, data)-> #为了后退的时候能够保存
#         if article.content isnt ""
#             CreateArticle(article.content)
#     EditorThreadModal $scope

# .controller 'editorCtrl', ($scope,GlobalVar,SaveArticle,EditorThreadModal)-> # 改 
#     element=document.querySelector('.keyboard-attach')
#     element.addEventListener "touchstart", (e)->
#         e.preventDefault()
#     window.addEventListener('native.keyboardshow', keyboardShowHandler)
#     window.addEventListener('native.keyboardhide', keyboardHideHandler)
#     keyboardHideHandler = (e)->
#         $scope.show = false
#     keyboardShowHandler = (e)->
#         $scope.show = true
#     $scope.stopPro = ($event)->
#         cordova.plugins.Keyboard.close()
#     $scope.show = true
#     $scope.article = GlobalVar.article
#     $scope.originContent = $scope.article.content
#     $scope.$on "$ionicView.beforeLeave", (event, data)-> #为了后退的时候能够保存
#         if $scope.article.content isnt $scope.originContent
#             SaveArticle($scope.article.content,$scope.article.item_id)
#     EditorThreadModal $scope