module.exports = angular.module('thread.controller',[])
.controller 'bricksCtrl',($scope,GlobalThread)->
    $scope.bricks=GlobalThread.bricks;
    
