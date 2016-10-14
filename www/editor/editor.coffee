module.exports = angular.module('editor',[
    require('./editor.services.coffee').name,
    require('./editor.resource.coffee').name,
])
.directive 'editorFooter', ->
    {
        restrict: 'EA'
        templateUrl:'editor/editor-footer.html'
    }

# dependency
# .directive 'myEditor', ()->
#     {
#         restrict: 'EA'
        # templateUrl:'editor/editor-tpl.html'
        # link: (scope, element, attributes)->
            
    # }

