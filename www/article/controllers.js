app
    .controller('welcome',function($scope,$location){
        $scope.redirect=function(){
            $location.path('/tab/articles/plan');            
        };
    })
    .controller('articlesCtrl', function($scope,editorProvider){//$scope, Get_items_by_thread,instance,$state) {
        editorProvider.execute($scope);
    })

    /* 默认进入这个标签页，而不是category页 */
    .controller('articlePlanCtrl',function($scope,$stateParams,Get_items_by_type_and_thread,instance,expandPool){
        var storage=window.localStorage;
        if(!instance.list.type1){
          instance.list.type1=JSON.parse(storage.getItem("type1"));
        }
        
        expandPool.execute(instance.list.type1);
        $scope.pool=instance.pool;
        $scope.articles=instance.list.type1;
    })

    .controller('articleHintCtrl',function($scope,$stateParams,Get_threads,instance,expandPool,Get_items_by_type_and_thread,$ionicModal,addDecimal){
        var storage=window.localStorage;
        if(!instance.list.type2){
          instance.list.type2=JSON.parse(storage.getItem("type2"));
        }
        expandPool.execute(instance.list.type2);
        addDecimal.execute(instance.list.type2);
        instance.list.type2.sort(function(a,b){
            return -(instance.pool['item'+a]["decimal"] - instance.pool['item'+b]["decimal"]);
        });
        $scope.pool=instance.pool;
        $scope.articles=instance.list.type2;
    })

    .controller('articleDeduceCtrl',function($scope,$stateParams,Get_items_by_type_and_thread,instance,expandPool){
        var storage=window.localStorage;
        if(!instance.list.type0){
            instance.list.type0=[];
        }
        instance.list.type0=JSON.parse(storage.getItem("type0"));
        expandPool.execute(instance.list.type0);
        $scope.pool=instance.pool;
        
        //lazyload
        var start=0;
        var end=20;
        $scope.articles=[];
        $scope.articles.push.apply($scope.articles,instance.list.type0.slice(start,end) );

        $scope.loadMore = function() {
            start+=20;
            end+=20;
            $scope.articles.push.apply($scope.articles,instance.list.type0.slice(start,end) );
            $scope.$broadcast('scroll.infiniteScrollComplete');
        };

        $scope.moreDataCanBeLoaded=function(){
            return instance.list.type0.length>end;
        }

        $scope.doRefresh = function() {
            $scope.$broadcast('scroll.refreshComplete');  
        };
    })
    .controller('articleReadCtrl',function($scope,$stateParams,Get_items_by_type_and_thread,instance,expandPool){
        var storage=window.localStorage;
        if(!instance.list.type3){
            instance.list.type3=JSON.parse(storage.getItem("type3"));
        }
        expandPool.execute(instance.list.type3);
        $scope.pool=instance.pool;
        $scope.articles=instance.list.type3;
    })


    .filter('switchType2', function () {
        return function (input) {
            input = input || '';
            var output = '';
            switch(input){
                case '0':case 0:
                output='执行';
                break;
                case '1':case 1:
                output='空闲';
                break;
                case '2':case 2:
                output='收集';
                break;
                case '3':case 3:
                output='思考';
                break;
                case '4':case 4:
                output='观察总结';
                break;
            }

            return output;
        };
    })

    .filter('switchReminder', function () {
        return function (input) {
            input = input || '';
            var output = '';
            // timeStr=timeStr*1000;
            timeStr=input;

            var time_distance=(Date.parse(new Date()) - timeStr)/1000/60/60/24;
            var hours=new Date(timeStr).getHours();

            var days='';
            var phase='';
            if( new Date().toLocaleDateString() != new Date( timeStr ).toLocaleDateString() ){
                if(time_distance>2){
                    if(time_distance>3){
                        if(time_distance>4){
                            if(time_distance>5){
                                if(time_distance>6){
                                    if(time_distance>7){
                                        if(time_distance>14){
                                            if(time_distance>21){
                                                if(time_distance>31){
                                                    days= '很久前';
                                                }else{
                                                    days= '3周前';
                                                }
                                            }else{
                                                days= '2周前';
                                            }
                                        }else{
                                            days= '1周前';
                                        }
                                    }else{
                                        days= '6天前';
                                    }
                                }else{
                                    days= '5天前';
                                }
                            }else{
                                days= '4天前';
                            }
                        }else{
                            days= '3天前';
                        }
                    }else{
                        days= '前天';
                    }
                }else{
                    days= '昨天';
                }
            }else{
                days= '今天';
            }

            if(hours>=1){
                if(hours>=6){
                    if(hours>=8){
                        if(hours>=11){
                            if(hours>=14){//大于等于才行
                                if(hours>=18){
                                    if(hours>=23){
                                        phase= '深夜';
                                    }else{
                                        phase= '晚上';
                                    }
                                }else{
                                    phase= '下午';
                                }
                            }else{
                                phase= '中午';
                            }
                        }else{
                            phase= '上午';
                        }
                    }else{
                        phase= '清晨';
                    }
                }else{
                    phase= '凌晨';
                }
            }else{
                phase= '凌晨1点前后';
            }
            // return days+'的'+phase;
            output=days;
            return output;
        };
    })

    ;
