# require("../entry/app.coffee")
# require('angular-mocks')

describe '测试列表的主服务List服务', ()->
    scope={}
    scope.$on=()->'api'
    beforeEach angular.mock.module 'app' 
    beforeEach angular.mock.inject (List)->
        List scope
    it 'list属性',()->
        expect(scope.list).to.not.be.undefined
    it 'list有notes这个主要属性',()->
        expect(scope.list.notes).to.not.be.undefined
    it '有删除的api',()->
        expect(scope.list.delete).to.not.be.undefined
    it '有新增的api',()->
        expect(scope.list.insert).to.not.be.undefined
    it '有展示SetRelationModal的api,直接从editor拿过来',()->
        expect(scope.list.showSetRelationModal).to.not.be.undefined
    it '有设置ClockModal的api，直接从editor拿过来',()->
        expect(scope.list.showSetClockModal).to.not.be.undefined
    it '点击文字进入编辑器',()->
        expect(scope.list.openEditorModal).to.not.be.undefined
