module.exports = angular.module('starter.controller',[])
.controller 'bricksCtrl',($scope,GlobalThread)->
    $scope.bricks=GlobalThread.bricks;
    
