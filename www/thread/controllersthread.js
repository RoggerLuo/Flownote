app    
    .controller('threadList',function($scope,Httprq,Get_threads,instance){
        if(!instance.thread_list){
            instance.thread_list=Get_threads.execute();            
        }
        // instance.thread_list=Get_threads.execute();
        $scope.threads=instance.thread_list;
    })

    /* 为了把thread传递给各个标签 */
    .controller('articleCategory',function($scope,editorProvider){  //$state,$stateParams,Get_items_by_type_and_thread,instance,$ionicModal,Get_threads,Operation_handler
        editorProvider.execute($scope);
    })

    /* 默认进入这个标签页，而不是category页 */
    .controller('planCtrl',function($scope,$stateParams,Get_items_by_type_and_thread,instance){
        instance.articleCategoryThreadId=$stateParams.thread_id;
        var data=Get_items_by_type_and_thread.execute(instance.articleCategoryThreadId,"1");    
        $scope.pool=instance.pool;
        $scope.articles=data;
    })

    .controller('hintCtrl',function($scope,$stateParams,Get_threads,instance,Get_items_by_type_and_thread,$ionicModal){
        //data要放在pool前面//先用get_获取data
        var data=Get_items_by_type_and_thread.execute(instance.articleCategoryThreadId,"2");            
        $scope.pool=instance.pool;
        data.sort(function(a,b){
            return -($scope.pool['item'+a]["decimal"] - $scope.pool['item'+b]["decimal"]);
        });
        $scope.articles=data;
    })

    .controller('deduceCtrl',function($scope,instance,$stateParams,Get_items_by_type_and_thread){
        // console.log('thread:'+instance.articleCategoryThreadId+','+"deduce ");
        var data=Get_items_by_type_and_thread.execute(instance.articleCategoryThreadId,"0");    
        $scope.pool=instance.pool;
        $scope.articles=data;
    })
    
    .controller('readCtrl',function($scope,instance,$stateParams,Get_items_by_type_and_thread){
        var data=Get_items_by_type_and_thread.execute(instance.articleCategoryThreadId,"3");  
        $scope.pool=instance.pool;
        $scope.articles=data;
    })


    .controller('threadEdit',function($scope,instance,Get_threads,Get_items_by_type_and_thread,$ionicModal,Operation_handler){
        /*
        在angular开发中angular controller never 包含DOM元素（html/css），在controller需要一个简单的POJO（plain object javascript object），与view完全的隔离（交互angularjs框架的职责
        不建议将class放入controller scope之上，scope需要保持纯洁行，scope上的只能是数据和行为
        */
        $scope.originalData={};

        if(!instance.thread_list){
            instance.thread_list=Get_threads.execute();            
        }
        $scope.threads=instance.thread_list;

        $scope.data = {
            showDelete: false
        };

        $scope.editData={
            text:'',
            color:'button-stable',
            stuff:'false',
            thread_id:'new',
        };

        $scope.cancel=function(){
            $scope.editData.text=$scope.originalData.text;
            $scope.editData.color=$scope.originalData.color;
            $scope.editData.stuff=$scope.originalData.stuff;
            $scope.modal.hide();
        };

        $scope.create=function(){

            if(!$scope.editData.text){
                return false;
            }
            if($scope.editData.thread_id=='new'){
                var obj=Operation_handler.thread.create($scope.editData);
                $scope.threads.unshift(obj);                
            }else{
                if(
                    $scope.originalData.text!=$scope.editData.text
                    ||
                    $scope.originalData.color!=$scope.editData.color
                    ||
                    $scope.originalData.stuff!=$scope.editData.stuff
                    )
                {
                    Operation_handler.thread.modify($scope.editData);
                }
            }
        };

        $scope.modify=function(){
            if($scope.editData.text){
                var obj=Operation_handler.thread.create($scope.editData.text,$scope.editData.color);
                $scope.threads.unshift(obj);
            }
        };

        $scope.edit = function(thread) {
          alert('Edit Item: ' + thread.thread_id);
        };

        $scope.share = function(thread) {
          alert('Share Item: ' + thread.thread_id);
        };
        
        $scope.moveItem = function(thread, fromIndex, toIndex) {
            $scope.threads.splice(fromIndex, 1);
            $scope.threads.splice(toIndex, 0, thread);
            var result=[];
            for (var i = 0; i < $scope.threads.length; i++) {
                result.unshift($scope.threads[i].thread_id);
            }
            var list_obj=JSON.stringify(result);
            window.localStorage.setItem("all_threads_list",list_obj);
        };
        
        $scope.remove = function(thread) {
            if(thread.item_list.length!=0){
                alert('请先清空分类下的文章');
                return false;
            }

            var r=confirm("确定要删除"+thread.text+"?");

            if(r){
                $scope.threads.splice($scope.threads.indexOf(thread), 1);
                // console.log('delete');
                Operation_handler.thread.delete(thread);                
            }
        };


        /**************/
        /* ionicModal */
        /**************/

        $ionicModal.fromTemplateUrl('account/thread-edit-modal.html', {
            scope: $scope,
            animation: 'slide-in-up'
        })
        .then(function(modal) {
            $scope.modal = modal;
            $scope.threads=instance.thread_list;
        });
        
        $scope.openModal = function(thread) {
            $scope.modal.show();
            if(thread){
                $scope.editData=thread;
                $scope.originalData=JSON.parse(JSON.stringify( thread ));
                // console.log($scope.originalData);
                /* 根目录显示不出来,以及根目录不能被删除 */
            }
        };
        $scope.closeModal = function() {
            $scope.modal.hide();
        };

        // Cleanup the modal when we're done with it!
        $scope.$on('$destroy', function() {
            $scope.modal.remove();
        });
        // Execute action on hide modal
        $scope.$on('modal.hidden', function() {
            // Execute action
        });
        // Execute action on remove modal
        $scope.$on('modal.removed', function() {
            // Execute action
        });


    })
    ;








