# require("../entry/app.coffee")
# require('angular-mocks')

describe 'retrospect以及其子页面', ()->
    scope ={} 
    beforeEach angular.mock.module 'app' 
    beforeEach angular.mock.inject ($rootScope, $controller)->
        scope = $rootScope.$new()
        $controller('retrospect', {$scope: scope})

    it '实现下拉刷新每个分类的统计数据，有doRefresh接口', ()->
        expect(scope.doRefresh).to.not.be.undefined

    # describe 'mainlist-tpl的交互的api声明,声明式编程',()->
    #     it '加载main-list,拥有list属性', ()->
    #         expect(scope.list).to.not.be.undefined
    #     it 'list有notes这个主要属性', ()->
    #         expect(scope.list.notes).to.not.be.undefined
    #     it '点击左边的小图片可以设置thread分类', ()->
    #         expect(scope.list.showSetRelationModal).to.not.be.undefined
    #     it '点击文字进入编辑器', ()->
    #         expect(scope.list.openEditorModal).to.not.be.undefined
    #     it '点击右边小图标可以快速设置提醒时间', ()->
    #         expect(scope.list.showSetClockModal).to.not.be.undefined
    #     it '左划删除的api', ()->
    #         expect(scope.list.delete).to.not.be.undefined
        
    # describe 'note-tpl交互接口',()->
    #     it '加载了editor', ()->
    #         expect(scope.editor).to.not.be.undefined
    #     it '调出编辑器，新增文章', ()->
    #         expect(scope.editor.openEditorModal).to.not.be.undefined

    # describe 'note页面的定制逻辑设定',()->
    #     it 'setRelation的时候删除文章', ()->
    #         expect(scope.editor.onSetRelationEnd).to.equal(scope.list.remove)
    #     it 'setPlan删除文章', ()->
    #         expect(scope.editor.onSetPlanEnd).to.equal(scope.list.remove)
    #     it 'setClock删除文章', ()->
    #         expect(scope.editor.onSetClockEnd).to.equal(scope.list.remove)
    #     it '新增的时候插入文章', ()->
    #         expect(scope.editor.onCreateEnd).to.equal(scope.list.insert)




