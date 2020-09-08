### 业务逻辑
#### 功能
+ 获取用户定位显示所在区域数据
+ 用户可以点赞为抗疫助力
+ 防护知识：文章、视频
+ 用户注册
+ 用户登录
+ 用户点击图片、昵称、电话、地址就能直接修改信息
+ 用户上传动态
+ 捐献请求信息追踪
+ 展示所有状态为已送达的捐赠信息
#### 页面统计
|页面|功能|
|:---|:---|
|首页|获取定位，点赞助力|
|文章/视频页|防护知识，置顶通知|
|统计页|捐献物资统计|
|动态页|用户上传动态，信息展示|
|表单页|用户提交捐献物资请求|
|切换地区页|选择查看区域的页面|
|注册页|用户注册|
|登录页|用户登录|
|我的|个人信息页|
|信息设置页|用户信息设置|
|信息追踪页|用户捐献物资信息追踪|

### 数据库设计
*user表：存放用户信息*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|uid|用户id|int|primary key,auto_increment|
|unick|用户昵称|varchar()|not null,default|
|uname|用户登录名|varchar()|not null,unique|
|upwd|用户密码|varchar()|not null|
|uavatar|用户头像|varchar()|not null,default|
|ugender|用户性别|enum|default|
|islike|用户是否点赞助力|enum|default|
|uphone|用户电话号码|int(11)||
|uaddress|用户地址|varchar()||

*article表：存放防护知识文章信息，疫苗研制最新情况*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|aid|文章/视频id|int|primary key,auto_increment|
|asubject|文章/视频标题|varchar()|not null|
|acontent|文章内容/视频路径|varchar()|not null|
|atime|发布时间|bigint|not null|
|aimport|是否置顶|enum|not null,default|
|type|类型|enum|not null|

*dynamic表：存放用户上传动态*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|dtext|用户动态文本|varchar|not null|
|dimg|用户动态图片路径|varchar||
|dtime|发布时间|bigint|not null|
|uid|用户id|int|not null,foreign key reference|

*donation表：记录捐献数据*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|did|捐赠物资id|int|primary key,auto_increment|
|dtype|捐赠类型|enum|not null,defalut|
|ddetail|捐赠物资详情|varchar()|not null|
|dtime|捐赠时间|bigint|not null|
|dstate|捐赠状态|enum|not null,default|
|uid|用户id|int|not null,foreign key reference|

*region_data表：记录区域数据*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|pname|省份名称|varchar|not null,unique|
|cname|城市名称|varchar|not null|
|confirm|确诊人数|int|not null|
|suspect|疑似人数|int|not null|
|heal|治愈人数|int|not null|
|dead|死亡人数|int|not null|

*country_data表：记录每个日期全国数据*
|表字段|备注|列类型|列约束|
|:---|:---|:---|:---|
|insert_date|数据插入日期|varchar|not null|
|confirm|确诊人数|int|not null|
|suspect|疑似人数|int|not null|
|heal|治愈人数|int|not null|
|dead|死亡人数|int|not null|
|input|境外输入人数|int|not null|