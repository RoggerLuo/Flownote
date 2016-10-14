##v.2.0
- 修改setClock的点击区域范围
- 在设置里面增加同步按钮
- 主列表显示type:0，无论是否设置thread

>Oct. 14th


##v1.2.0
- 重构大部分代码，视图 数据 逻辑 通用逻辑 完全分离
- 实践测试先行的编程方法
- 使用karma和angular-mock自动化测试，辅助以上几个层面的api分离
- 把**<按“未处理－提醒－计划”顺序排序的文章列表>**作为整个app的核心功能
- 修改视图和交互，把提醒和分类功能集成到首页，直接显示每篇笔记的所有文字，去掉<内容描述>部分，缩小字号，缩小左边图标，拓宽文字显示部分，调整分类信息展示的位置.
- 新增内置数据库dbModel，每次通过遍历获取信息
- 解决潜在preSave问题：如果create在setType之后就会找不到item_id

>Oct. 8th

##v1.1.4
- 修复thread填充颜色stuff属性显示错误
- 在retropect页面增加显示部分articleList
- raw分类的概念改成Cue

>Sept. 22th


##v1.1.3
- thread的排序可以保存，增加一个order_index字段

##v1.1.2
- 把raw改成history
- 删除keyboardAttachmentSE
- 给threadModal加上KBAttachment
- 修改了threadList的是否填色的bug，
- 残留localStorage代码让thread删除失效

原因是对于toggle组件'false'和false是不同的,
mysql会把true存成字符串

>Sept. 15th

##v1.1.1
- 在hover分类里，重新设置提醒周期时，每次将重新计算提醒时间和排序

执行代码写在各自的controller的checkMatch里，相当于一个切片。每次初始化controller会加载执行代码，每次setRelation和setType都会执行checkMatch这个切片检查。然后再执行是否删除article（这个是预先写的目标，现在切片的副产品却变成了主要功能，是时候给checkMatch换个名字了）

> Sept. 14th

##v1.1.0
###  取消了calendar界面，增加分类查看界面
- 增加一个查看所有文章的tab,删掉了calendar的tab
- 增加了两个后端api，可是实时获得当前不同分类的文章数量
- 增加了ListOperation，对文章进行分类等操作时，会实时更新列表，分类之后不属于当前分类列表的文章会马上移出列表
- 增加了new按钮，可以快速新建文章
- 设置分类时，增加弹出提醒，700ms后自动消失

> Sept. 11th 


##v1.0.1 
- 使用版本号，并针对每个版本的修改做简单记录
- 把一些本来放在data(setting)标签页的东西，放回模块所属页面，方便操作，比如thread的名称和样式修改

> Aug. 29th

##v1.0.0

* article调整分类（thread）之后，articleList无法同步，需要重新加载本页才能刷新视图
* 每个thread的文章数量统计也无法及时更新，必须访问articleList才能更新
* 没有身份校验，没有分帐号
* textarea在ios上无法滚动