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