'use strict';

angular.
	module('data').
	factory('editorProvider',function($state,$ionicModal,Get_threads,Operation_handler,RemoveFunc,instance,addDecimal){
		var storage=window.localStorage;

		var editorProvider=function($scope){
			/* ionicModal : editor modal*/
			$ionicModal.fromTemplateUrl('editor/editor-modal.html', {
			    scope: $scope,
			    animation: 'slide-in-up'
			})
			.then(function(modal) {
			    $scope.modal = modal;
			});
			$scope.newArticle = function(){
				$scope.item = {};
				$scope.item.content = "";
				$scope.item.date_and_time=Date.parse(new Date())/1000;
				$scope.item.item_id="new";//$scope.item.date_and_time.toString();
				$scope.item.remind_time='0';
				$scope.item.remind_text='';
				$scope.item.type='0';
				$scope.item.type2='0';
				$scope.item.thread_id='0';
				$scope.originalData=JSON.parse(JSON.stringify( $scope.item ));//为了判断是否 有改动，保存初始值
				$scope.modal.show();
			};

			$scope.openModal = function(item) { //传入所选择的item
			    $scope.item = item ;
			    $scope.originalData=JSON.parse(JSON.stringify( item ));//为了判断是否 有改动，保存初始值
			    $scope.modal.show();

			};
			$scope.closeModal = function() {
			    $scope.save();
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



			/* ionicModal : thread Modal*/
			$ionicModal.fromTemplateUrl('editor/thread-modal-for-thread.html', {
			    scope: $scope,
			    animation: 'slide-in-up'
			})
			.then(function(modal) {
			    $scope.threadModal = modal;
			    $scope.threads = Get_threads.execute();
			});
			
			$scope.openThreadModal = function() {
			    $scope.threadModal.show();
			};
			$scope.closeThreadModal = function() {
			    $scope.threadModal.hide();
			};

			/* item logic controller*/
			/* view control */
			$scope.height = document.body.scrollHeight - 105 ;
			$scope.control={};
			$scope.control.showConcludeButton=false;
			$scope.control.showPlanButton=false;
			$scope.control.showRemindButton=false;
			$scope.view={};
			$scope.view.conclude="结论";

			$scope.save=function(){
			    var isModified=false;//是否修改
			    if($scope.originalData.content==$scope.item.content){}else{
			        isModified=true;
			    }

			    if(isModified){
			    	if($scope.item.item_id=="new"){
			    		//返回获得id
			    		$scope.item.item_id=Operation_handler.item.create($scope.item.content,$scope.item.date_and_time);
			    		//添加到 deduce链表
			    		if(!instance.list.type0){
			    		  instance.list.type0=JSON.parse(storage.getItem('type0'));
			    		}
			    		instance.list.type0.unshift($scope.item.item_id);
			    	}else{
			    		Operation_handler.item.saveContent($scope.item.content,$scope.item.item_id);			    		
			    		
			    		// if($scope.item.type==2){

			    		// 	addDecimal.execute(instance.list.type2);
			    		// 	instance.list.type2.sort(function(a,b){
			    		// 	    return -(instance.pool['item'+a]["decimal"] - instance.pool['item'+b]["decimal"]);
			    		// 	});
			    		// }
			    	}

			    }
			};

			$scope.thread_change=function(thread_id){
			    if($scope.item.item_id=="new"){
			        $scope.save();
			    }
			    Operation_handler.item.item_set_relation($scope.item.item_id,thread_id);
			};
			$scope.type_change=function(type){
				if(type==$scope.item.type){return false;}
				if($scope.item.type===undefined){$scope.item.type=0;}
			    //没保存则先保存
			    if($scope.item.item_id=="new"){
			        $scope.save();
			    }
			    //清除之前的链表
			    if(!instance.list['type'+$scope.item.type]){
			      instance.list['type'+$scope.item.type]=JSON.parse(storage.getItem('type'+$scope.item.type));
			    }
			    RemoveFunc.call(instance.list['type'+$scope.item.type],$scope.item.item_id);

			    var obj=JSON.stringify(instance.list['type'+$scope.item.type]);
			    storage.setItem('type'+$scope.item.type,obj);//保存到storage

			    //添加到新链表
			    if(!instance.list['type'+type]){
					// instance.list['type'+type]=[];
					instance.list['type'+type]=JSON.parse(storage.getItem('type'+type));
			    }
			    instance.list['type'+type].unshift($scope.item.item_id);
			    var obj=JSON.stringify(instance.list['type'+type]);
			    storage.setItem('type'+type,obj);//保存到storage

			    $scope.item.type=type;
			    Operation_handler.item.set_type($scope.item.item_id,$scope.item.type);
			};

			$scope.type2_change=function(type){
			    if($scope.item.item_id=="new"){
			        $scope.save();
			    }
			    $scope.item.type2=type;

			    instance.pool['item'+$scope.item.item_id].type2=type;
			    Operation_handler.item.set_type2($scope.item.item_id,$scope.item.type2);
			};


		};

		return {execute:editorProvider};

	}).

	factory('Httprq', ['$resource',
		function($resource) {
			return $resource('http://alice0115.applinzi.com/index.php/ngflow/:method', {method:'@method'}, 
				{
			    	query: {method:'JSONP', params: {callback: 'JSON_CALLBACK'}, isArray:false}
				}
			);
		}
	]).
	
	factory('Threads_handler', 
		['Httprq','Items_handler',function(Httprq,Items_handler){
			var storage=window.localStorage;
			var dataModel={thread:{}};
			
			var store_thread = function(data){
				dataModel.thread.list=[];

				var thread={};
				thread.text='Roger';
				thread.color='button-stable';
				thread.stuff=false;
				thread.item_list=[];
				// thread.thread_list=[];
				thread.thread_id=0;
				thread.item_number=0;
				thread.father_id=0;
				var thread_obj=JSON.stringify(thread);
				storage.setItem("thread0",thread_obj);
				dataModel.thread.list.unshift('0');

			    for(var key=0;key<data.length;key++){
			    	var obj=data[key];

			    	//if father does not exist, create
			    	// if(!storage.getItem("thread"+obj.father_id)){
			    	// 	var thread={};
			    	// 	thread.item_list=[];
			    	// 	// thread.thread_list=[obj.thread_id];
			    	// 	thread.thread_id=obj.father_id;
			    	// 	thread.item_number=0;
			    	// 	// thread.type2_item_number=0;//新加的

			    	// 	var thread_obj=JSON.stringify(thread);
			    	// 	storage.setItem("thread"+obj.father_id,thread_obj);
			    	// }else{//if exist,add current thread
			    	// 	var father=JSON.parse(storage.getItem("thread"+obj.father_id));
			    	// 	// father.thread_list.unshift(obj.thread_id);
			    		
			    	// 	var father_obj=JSON.stringify(father);
			    	// 	storage.setItem("thread"+obj.father_id,father_obj);//保存到storage

			    	// }

			    	if(!storage.getItem("thread"+obj.thread_id)){
			    		var thread={};
			    		thread.thread_id=obj.thread_id;
			    		thread.stuff=obj.stuff;
			    		thread.text=obj.thread_text;
			    		thread.color=obj.color;
			    		thread.item_list=[];


			    		// thread.item_number=0;
			    		//thread.thread_id=
			    		// thread.thread_list=[];
			    		// thread.type2_item_number=0;//新加的

			    		var thread_obj=JSON.stringify(thread);
			    		storage.setItem("thread"+obj.thread_id,thread_obj);

			    	}else{//if exist already
			    		var thread_obj=JSON.parse(storage.getItem("thread"+obj.thread_id));
			    		thread_obj.text=obj.thread_text;
			    		thread_obj.father_id=obj.father_id;
			    		var thread_obj=JSON.stringify(thread_obj);
			    		storage.setItem("thread"+obj.thread_id,thread_obj);//保存到storage
			    	}
			    	dataModel.thread.list.unshift(obj.thread_id);
			    }
			    var list_obj=JSON.stringify(dataModel.thread.list);
			    storage.setItem("all_threads_list",list_obj);//保存到storage
			}

			var execute=function(){
				var promise = Httprq.query({method:'download_thread'}).$promise;
				promise.then(function(res){
					store_thread(res.data);
					Items_handler.execute();//一个接一个//也许用then更好，但是我还不会，为了效率着想，先这样呗
				});
			}

			return {
			    execute: execute,
			    dataModel:dataModel
			};
		}
	]).

	factory('Items_handler', 
		['Httprq','sync_timestamp',function(Httprq,sync_timestamp,instance){
			var storage=window.localStorage;
			var dataModel={thread:{}};

			//如果type不存在则创建一个
			for (var x = 0; x < 4; x++) {
				if(!storage.getItem("type"+x)){ 
					storage.setItem("type"+x,JSON.stringify([]));
				}
			}

			var store_item = function(data){
			    for(var key=0;key<data.length;key++){
			    	var obj=data[key];

			    	//给thread里面添加 相应的 item
		    		var father_thread=JSON.parse(storage.getItem("thread"+obj.thread_id));
		    		if(!father_thread){continue;}
		    		father_thread.item_list.unshift(obj.item_id);
		    		var father_obj=JSON.stringify(father_thread);
		    		storage.setItem("thread"+obj.thread_id,father_obj);//保存到storage
		    		
		    		//把item放入链表中
	    			var type_obj=JSON.parse(storage.getItem("type"+obj.type));
	    			type_obj.unshift(obj.item_id);
	    			var type_obj_string=JSON.stringify(type_obj);
	    			storage.setItem("type"+obj.type,type_obj_string);//保存到storage
		    		

		    		//创建自己
		    		var item={};
		    		item.content=obj.content;
		    		item.item_id=obj.item_id;
		    		item.date_and_time=obj.date_and_time;
		    		item.remind_time=obj.remind_time;
		    		item.remind_text=obj.period_words;
		    		item.thread_id=obj.thread_id;
		    		item.type=obj.type;
		    		item.type2=obj.type2;


		    		var item_obj=JSON.stringify(item);
		    		storage.setItem("item"+obj.item_id,item_obj);
		    		
				}

			};
			var execute=function(){
				var promise = Httprq.query({method:'download_item'}).$promise;
				promise.then(function(res){
					store_item(res.data);
					sync_timestamp.execute();

				});
			}
			return {
			    execute: execute,
			    dataModel:dataModel
			};
		}
	]).

	factory('sync_timestamp', 
		['Httprq','$location',function(Httprq,$location){
			var storage=window.localStorage;
			var execute=function(){
				var timestamp=Date.parse(new Date())/1000;
				var promise = Httprq.query({method:'sync_timestamp',timestamp:timestamp}).$promise;
				promise.then(function(res){
					storage.setItem('sync_timestamp',timestamp);
					$location.path('/tab/articles/plan');
				});
			}
			return {
			    execute: execute
			};
		}
	]).
	factory('RemoveFunc',function(){
		var removeFunc = function(val) {
			var index = this.indexOf(val);
			if (index > -1) {
				this.splice(index, 1);
			}
		};
		return removeFunc;
	}).
	factory('Operation_handler',function(Httprq,AjaxQueue,RemoveFunc){
			
			var storage=window.localStorage;
			var ajaxQueue=AjaxQueue;
			var dataModel={
				command:function(command_name,obj){
					var command={};
					command[command_name]=obj;
					ajaxQueue.queue.push(command);
					storage.setItem('ajax_queue',JSON.stringify(ajaxQueue.queue));
					//马上开始动作
					ajaxQueue.polling();
				},
				timer:{
					reclock:function(item_id){
						item_id=item_id.toString();//转换成字符串

						var item_obj=JSON.parse(storage.getItem("item"+item_id));//为了获取thread_id
						var seconds=item_obj.remind_time-item_obj.date_and_time;
						item_obj.date_and_time=Date.parse(new Date())/1000;
						item_obj.remind_time=item_obj.date_and_time+seconds;
						var obj=JSON.stringify(item_obj);
						storage.setItem("item"+item_id,obj);//保存到storage

						//给列队里添加指令
						var obj={item_id:item_id};
						dataModel.command('timer_reclock',obj);
					},
					set:function(paraObj){
						var item_id=paraObj.item_id;
						var seconds=paraObj.seconds;
						var words=paraObj.words;
						var item_obj=JSON.parse(storage.getItem("item"+item_id));//为了获取thread_id
						item_obj.remind_time=(item_obj.date_and_time-0)+(seconds-0);
						item_obj.remind_text=words;
						var obj=JSON.stringify(item_obj);
						storage.setItem("item"+item_id,obj);//保存到storage

						//给列队里添加指令
						var obj={item_id:item_id,seconds:seconds,remind_text:words};
						dataModel.command('timer_set',obj);

						dataModel.timer.reclock(item_id);
					},
				},
				item:{
					refresh_order:function(item_id){
						var item_obj=JSON.parse(storage.getItem("item"+item_id));
						var thread_obj=JSON.parse(storage.getItem("thread"+item_obj.thread_id));
						thread_obj.item_list.remove(item_id);
						thread_obj.item_list.unshift(item_id);
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+item_obj.thread_id,obj);//保存到storage
					},
					set_type:function(item_id,type){
						item_id=item_id.toString();//转换成字符串

						//删除type链表和thead数量
						// dataModel.item_observer(item_id,'out');//observer

						var item_obj=JSON.parse(storage.getItem("item"+item_id));
						item_obj.type=type;
						var obj=JSON.stringify(item_obj);
						storage.setItem("item"+item_id,obj);//保存到storage

						//增加type链表和thead数量
						// dataModel.item_observer(item_id,'in');

						//给列队里添加指令
						var obj={item_id:item_id,type:type};
						dataModel.command('item_set_type',obj);
						
						//刷新在thread里面的排序
						// this.refresh_order(item_id);
					},

					set_type2:function(item_id,type){
						item_id=item_id.toString();//转换成字符串

						//删除type链表和thead数量
						// dataModel.item_observer(item_id,'out');//observer

						var item_obj=JSON.parse(storage.getItem("item"+item_id));
						item_obj.type2=type;
						var obj=JSON.stringify(item_obj);
						storage.setItem("item"+item_id,obj);//保存到storage

						//增加type链表和thead数量
						// dataModel.item_observer(item_id,'in');

						//给列队里添加指令
						var obj={item_id:item_id,type:type};
						dataModel.command('item_set_type2',obj);						
					},
					item_set_relation:function(item_id,thread_id){
						item_id=item_id.toString();//转换成字符串
						thread_id=thread_id.toString();//转换成字符串

						//删除type链表和thead数量
						// dataModel.item_observer(item_id,'out');//observer
						
						//先删除关系
						dataModel.item.delete_relation(item_id);
						
						//再添加关系
						var thread_obj=JSON.parse(storage.getItem("thread"+thread_id));
						thread_obj.item_list.unshift(item_id);
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+thread_id,obj);//保存到storage

						//更改自己内部的thread_id
						var item_obj=JSON.parse(storage.getItem("item"+item_id));
						item_obj.thread_id=thread_id;
						item_obj.date_and_time=Date.parse(new Date())/1000;
						var obj=JSON.stringify(item_obj);
						storage.setItem("item"+item_id,obj);//保存到storage

						//增加type链表和thead数量
						// dataModel.item_observer(item_id,'in');

						//给列队里添加指令
						dataModel.command('item_set_relation',item_obj);			
					},
					delete_relation:function(item_id){
						item_id=item_id.toString();//转换成字符串
						
						var item_obj=JSON.parse(storage.getItem("item"+item_id));//为了获取thread_id
						var thread_obj=JSON.parse(storage.getItem("thread"+item_obj.thread_id));

						RemoveFunc.call(thread_obj.item_list,item_id);

						// thread_obj.item_list.remove(item_id);
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+item_obj.thread_id,obj);//保存到storage
					},
					delete:function(item_id){
						item_id=item_id.toString();//转换成字符串

						//删除type链表和thead数量
						dataModel.item_observer(item_id,'out');//observer

						//删除thread关系			
						dataModel.item.delete_relation(item_id);

						//从storage里清除
						storage.removeItem('item'+item_id);

						//给列队里添加指令
						var obj={item_id:item_id};
						dataModel.command('item_delete',obj);
					},
					
					create:function(content,date_and_time){
						var item={};
						item.content=content;
						item.date_and_time=date_and_time;
						item.item_id=item.date_and_time.toString();
						item.remind_time='0';
						item.remind_text='';
						item.type='0';
						item.type2='0';
						item.thread_id='0';

						var obj=JSON.stringify(item);
						storage.setItem('item'+item.item_id,obj);//保存到storage
						dataModel.thread.addItem(item.item_id);//添加relation

						//给列队里添加指令
						dataModel.command('item_create',item);
						return item.item_id;
					},
					saveContent:function(content,item_id){
						item_id=item_id.toString();//转换成字符串

						var item_obj=JSON.parse(storage.getItem("item"+item_id));
						item_obj.content=content;
						
						/* 可能会引起remind出错 再说 */
						var distance=Date.parse(new Date())/1000-item_obj.date_and_time;
						item_obj.date_and_time=Date.parse(new Date())/1000;
						
						item_obj.remind_time+=distance;

						var data=JSON.stringify(item_obj);
						storage.setItem('item'+item_id,data);

						//给列队里添加指令
						dataModel.command('item_saveContent',item_obj);

						return item_obj;
					},		
				},
				thread:{
					list:[],
					create:function(editData){
						var thread_father_id='0';//thread_father_id.toString();//转换成字符串
						var thread_obj={};
						thread_obj.text=editData.text;
						thread_obj.color=editData.color;
						thread_obj.stuff=editData.stuff;
						thread_obj.date_and_time=Date.parse(new Date())/1000;
						thread_obj.thread_id=thread_obj.date_and_time.toString();
						// thread_obj.thread_list=[];
						thread_obj.item_list=[];
						thread_obj.item_number=0;
						
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+thread_obj.thread_id,obj);//保存到storage

						/* 获取threads_list,修改threads_list */
						dataModel.thread.list=JSON.parse(storage.getItem("all_threads_list"));
						dataModel.thread.list.push(thread_obj.thread_id);
						var list_obj=JSON.stringify(dataModel.thread.list);
						storage.setItem("all_threads_list",list_obj);//保存到storage

						//给列队里添加指令
						dataModel.command('thread_create',thread_obj);
						dataModel.thread.add(thread_obj.thread_id,thread_father_id);
						return thread_obj;
					},
					modify:function(thread_obj){
						var thread_id=thread_obj.thread_id.toString();//转换成字符串

						// var thread_obj=JSON.parse(storage.getItem("thread"+thread_id));
						// thread_obj.text=thread_obj.text;
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+thread_id,obj);//保存到storage

						//给列队里添加指令
						dataModel.command('thread_modify',thread_obj);
					},
					delete:function(thread_obj){
						var thread_id=thread_obj.thread_id.toString();//转换成字符串

						dataModel.thread.list=JSON.parse(storage.getItem("all_threads_list"));
						RemoveFunc.call(dataModel.thread.list,thread_id);

						var obj=JSON.stringify(dataModel.thread.list);
						storage.setItem("all_threads_list",obj);//保存到storage

						//给列队里添加指令
						var obj={thread_id:thread_obj.thread_id};
						dataModel.command('thread_delete',obj);

						// dataModel.thread.delete_thread_relation(thread_id);
						// storage.removeItem('thread'+thread_id);

						// var threads=dataModel.thread.list;
						// dataModel.thread.list.remove(thread_id);
					},
					move:function(thread_id,thread_father_id){
						thread_id=thread_id.toString();//转换成字符串
						thread_father_id=thread_father_id.toString();//转换成字符串


						dataModel.thread.delete_thread_relation(thread_id);
						dataModel.thread.add(thread_id,thread_father_id);
						
					},
					add:function(thread_id,thread_father_id){
						thread_id=thread_id.toString();//转换成字符串
						thread_father_id=thread_father_id.toString();//转换成字符串

						var father=JSON.parse(storage.getItem("thread"+thread_father_id));
						// father.thread_list.unshift(thread_id);
						var obj=JSON.stringify(father);
						storage.setItem("thread"+thread_father_id,obj);//保存到storage

						//给自己内部添加thread_father
						var thread_obj=JSON.parse(storage.getItem("thread"+thread_id));
						thread_obj.father_id=thread_father_id;
						var obj=JSON.stringify(thread_obj);
						storage.setItem("thread"+thread_id,obj);//保存到storage

						//给列队里添加指令
						var obj={thread_id:thread_id,thread_father_id:thread_father_id};
						dataModel.command('thread_move',obj);
					},
					delete_thread_relation:function(thread_id){
						thread_id=thread_id.toString();

						var thread_obj=JSON.parse(storage.getItem("thread"+thread_id));
						var father=JSON.parse(storage.getItem("thread"+thread_obj.father_id));
						// father.thread_list.remove(thread_id);
						var father_obj=JSON.stringify(father);
						storage.setItem("thread"+thread_obj.father_id,father_obj);//保存到storage
					},
					addItem:function(item_id){//addItem是把new item注册到thread里面来 
						item_id=item_id.toString();
						var thread=JSON.parse(storage.getItem('thread0'));
						thread.item_list.unshift(item_id);
						var data=JSON.stringify(thread);
						storage.setItem('thread0',data);
					},
				},
			};
			return  dataModel;
		}
	).

	factory('AjaxQueue', 
		['Httprq',function(Httprq){
			var storage=window.localStorage;

			var ajaxQueue={
				recorder:0,
				error_log:function(data,operate){
					this.recorder+=1;
					var promise = Httprq.query({method:'error_log',data:data,operate:operate}).$promise;
					promise.then(
						function(res){
						},
						function(res){
						}
					);
					if(recorder>10){
						this.queue=[];
					}

				},
				processLock:false,
				
				checkTask:function(){
					// debugger;
					var that=this;
					this.processLock=true;
					var queue=this.queue;

					if(queue.length==0){
						this.processLock=false;
						return false;
					}
					for(var  key in queue[0]){
						var obj=queue[0][key];

						switch(key){

							case "timer_reclock":
								var item_id=obj.item_id;
								var promise = Httprq.query({method:'refresh_timer',item_id:item_id}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,'timer_reclock');
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute timer_reclock");
									
									},
									function(res){
								   		ajaxQueue.error_log(res,'timer_reclock');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;

							case "timer_set":
								var item_id=obj.item_id;
								var seconds=obj.seconds;
								var words=obj.words;

								var promise = Httprq.query({method:'set_timer',item_id:item_id,seconds:seconds,words:words}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,'timer_set');
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute timer_set");
									},
									function(res){
								   		ajaxQueue.error_log(res,'timer_set');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;
							
							/*case "thread_move":
								var thread_id=obj.thread_id;
								var thread_father_id=obj.thread_father_id;
								var promise = Httprq.query({method:'thread_move',thread_id:thread_id,move_to_id:thread_father_id}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,'thread_move');
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute thread_move");							
									},
									function(res){
								   		ajaxQueue.error_log(res,'thread_move');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;*/

							case "thread_delete":
								var thread_id=obj.thread_id;
								var promise = Httprq.query({method:'thread_delete',thread_id:thread_id}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"thread_delete");
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute thread_delete");
									},
									function(res){
								   		ajaxQueue.error_log(res,'thread_delete');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;


							case "thread_create":
								var thread_id=obj.thread_id;
								var thread_text=obj.text;
								var color=obj.color;
								var stuff=obj.stuff;

								var promise = Httprq.query({method:'thread_create',thread_id:thread_id,thread_text:thread_text,color:color,stuff:stuff}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"thread_create");
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute thread_create");
									},
									function(res){
								   		ajaxQueue.error_log(res,'thread_create');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;



							case "thread_modify":
								var thread_id=obj.thread_id;
								var thread_text=obj.text;
								var color=obj.color;
								var stuff=obj.stuff;

								var promise = Httprq.query({method:'thread_modify',thread_id:thread_id,thread_text:thread_text,color:color,stuff:stuff}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"thread_modify");return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute thread_modify");
									},
									function(res){
								   		ajaxQueue.error_log(res,'thread_modify');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;

							case "item_set_type":
								var item_id=obj.item_id;
								var type=obj.type;

								var promise = Httprq.query({method:'change_type',item_id:item_id,type:type}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"item_set_type");
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute item_set_type");
									},
									function(res){
								   		ajaxQueue.error_log(res,'change_type');
									 	ajaxQueue.checkTask();
		  							}
								);

							break;

							case "item_set_type2":
								var item_id=obj.item_id;
								var type=obj.type;

								var promise = Httprq.query({method:'change_type2',item_id:item_id,type:type}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"item_set_type2");
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute item_set_type2");
									},
									function(res){
								   		ajaxQueue.error_log(res,'change_type2');
									 	ajaxQueue.checkTask();
		  							}
								);

							break;

							case "item_set_relation":
								var item_id=obj.item_id;
								var thread_id=obj.thread_id;

								var promise = Httprq.query({method:'item_to_thread',thread_id:thread_id,item_id:item_id}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
									   		ajaxQueue.error_log(data,"item_set_relation");
									   		return false;
									   	};
									   	ajaxQueue.queue.shift();
									   	storage.setItem('ajax_queue',JSON.stringify(queue));
									   	ajaxQueue.checkTask();
									   	console.log("ajax execute item_to_thread");
									},
									function(res){
								   		ajaxQueue.error_log(res,'item_to_thread');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;

							case "item_saveContent":
								var item_id=obj.item_id;
								var content=obj.content;
								var date_and_time=obj.date_and_time;


								var promise = Httprq.query({method:'item_saveContent',content:content,item_id:item_id,date_and_time:date_and_time}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){ajaxQueue.error_log(data,"item_saveContent");return false;};
										   	ajaxQueue.queue.shift();
										   	storage.setItem('ajax_queue',JSON.stringify(queue));
										   	ajaxQueue.checkTask();
										   	console.log("ajax execute saveContent");
									},
									function(res){
								   		ajaxQueue.error_log(res,'item_saveContent');
									 	ajaxQueue.checkTask();
		  							}
								);
			
							break;

							case "item_create":
								var item_id=obj.item_id;
								var content=obj.content;
								var date_and_time=obj.date_and_time;

								var promise = Httprq.query({method:'item_create',content:content,item_id:item_id,date_and_time:date_and_time}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
									   		that.error_log(data,"item_create");
									   		return false;
									   	};
									   	that.queue.shift();
									   	storage.setItem('ajax_queue',JSON.stringify(queue));
									   	that.checkTask();
									   	console.log("ajax execute item_create");
									},
									function(res){
								   		that.error_log(res,'item_create');
									 	ajaxQueue.checkTask();
		  							}
								);
							break;

							case "item_delete":
								var item_id=obj.item_id;
								var content=obj.content;
								var date_and_time=obj.date_and_time;


								var promise = Httprq.query({method:'item_delete',item_id:item_id}).$promise;
								promise.then(
									function(res){
										var data=res.data;
										if(data!=='ok'){
											ajaxQueue.error_log(data,"item_delete");
											return false;
										};
										ajaxQueue.queue.shift();
										storage.setItem('ajax_queue',JSON.stringify(queue));
										ajaxQueue.checkTask();
										console.log("ajax execute item_delete");

									},
									function(res){
								   		ajaxQueue.error_log(res,'item_delete');
									 	ajaxQueue.checkTask();
		  							}
								);						
							break;
						}
					}
				},
				polling:function(){//check the queue
					console.log("polling execute checkTask");
					if(this.processLock){return false;}
					this.checkTask();
				},
				queue:[],
			};
			return ajaxQueue;
		}


	])

	;
