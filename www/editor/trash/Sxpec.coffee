require('angular')
require('angular-mocks')
require("./editor.coffee")

describe 'Editor module', ()->
    $scope={}
    beforeEach angular.mock.module 'editor'
    beforeEach inject (_EditorService_)->
        _EditorService_ $scope
    
    describe 'Load service',()->

    #     # #模拟我们的Application模块并注入我们自己的依赖
        
    #     # #模拟Controller，并且包含 $rootScope 和 $controller
    #     beforeEach angular.mock.inject ($rootScope, $controller)->
    #         #创建一个空的 scope
    #         scope = $rootScope.$new()
    #         #声明 Controller并且注入已创建的空的 scope
    #         $controller('articlesCtrl', {$scope: scope})

    #     # # 测试从这里开始
    #     it 'should have variable text = "Hello World!"', ()->
    #         expect('ok').toBe("ok")

    # describe 'directive testing', () ->
    #     $compile = {}
    #     $rootScope = {}
    #     $httpBackend = {}
    #     # Load the myApp module, which contains the directive
    #     beforeEach angular.mock.module 'retrospect'
    #     # Store references to $rootScope and $compile
    #     # so they are available to all tests in this describe block
    #     beforeEach angular.mock.inject (_$compile_, _$rootScope_,_$httpBackend_)->
    #         # The injector unwraps the underscores (_) from around the parameter names when matching
    #         $compile = _$compile_
    #         $rootScope = _$rootScope_
    #         $httpBackend = _$httpBackend_
    #         # $httpBackend.when('GET', 'article/article-list.html').respond([{id: 1, name: 'Bob'}, {id:2, name: 'Jane'}])
             
    #     it 'Replaces the element with the appropriate content', () ->
    #         # Compile a piece of HTML containing the directive
    #         element = $compile("<my-list></my-list>")($rootScope)
    #         # $httpBackend.flush()

    #         # fire all the watches, so the scope expression 1 will be evaluated
    #         $rootScope.$digest()
    #         # Check that the compiled element contains the templated content
    #         expect(element.html()).toContain("lidless, wreathed in flame")
