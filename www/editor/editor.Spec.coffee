require("../entry/app.coffee")
require('angular-mocks')

describe '测试editor的服务', ()->
    scope={}
    scope.$on = (a,b)->'do nothing' #抓不到modal的回调，注入真实的scope会报错，所以fake一个
    beforeEach angular.mock.module 'app' 
    beforeEach angular.mock.inject (EditorService)->
        # scope = $rootScope.$new()
        EditorService scope

    describe 'Basic api',()->
        it '首先,editor对象',()->
            expect(scope.editor).to.not.be.undefined
        it '有打开editor的操作api',()->
            expect(scope.editor.openEditorModal).to.not.be.undefined
        it '有关闭editor的操作api',()->
            expect(scope.editor.closeEditorModal).to.not.be.undefined
        it '有关闭editor的操作api',()->
            expect(scope.editor.newEditorModal).to.not.be.undefined

    describe '高级api',()->
        it '有showSetClock 视图api',()->
            expect(scope.editor.showSetClockModal).to.not.be.undefined
        it '有showSetRelation 视图api',()->
            expect(scope.editor.showSetRelationModal).to.not.be.undefined
        it '直接setPlan的api',()->
            expect(scope.editor.setPlan).to.not.be.undefined

    describe '切片接口',()->
        it 'setRelationEnd',()->
            expect(scope.editor.onSetRelationEnd).to.not.be.undefined
        it 'setPlanEnd',()->
            expect(scope.editor.onSetPlanEnd).to.not.be.undefined
        it 'createEnd',()->
            expect(scope.editor.onCreateEnd).to.not.be.undefined


