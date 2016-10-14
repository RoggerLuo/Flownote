# require("../entry/app.coffee")
# require('angular-mocks')

describe 'Notes页面', ()->
    scope ={} 
    beforeEach angular.mock.module 'app' 
    beforeEach angular.mock.inject ($rootScope, $controller)->
        scope = $rootScope.$new()
        $controller('notesCtrl', {$scope: scope})

    describe 'mainlist-tpl的交互的api声明,声明式编程',()->
        
        it '实现了refresh的函数', ()->
            expect(scope.refresh).to.not.be.undefined
        it '实现下拉刷新，有doRefresh接口', ()->
            expect(scope.doRefresh).to.not.be.undefined
        it '可以调出编辑器', ()->
            expect(scope.editor.openEditorModal).to.not.be.undefined
                
                
    describe 'note页面的定制逻辑设定',()->
        
        it 'setRelation的时候删除文章', ()->
            expect(scope.editor.onSetRelationEnd).to.equal(scope.list.remove)
        it 'setPlan删除文章', ()->
            expect(scope.editor.onSetPlanEnd).to.equal(scope.list.remove)
        it 'setClock删除文章', ()->
            expect(scope.editor.onSetClockEnd).to.equal(scope.list.remove)
        it '新增的时候插入文章', ()->
            expect(scope.editor.onCreateEnd).to.equal(scope.list.insert)




