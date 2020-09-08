SET NAMES utf8;
DROP DATABASE IF EXISTS epi;
CREATE DATABASE epi CHARSET=utf8;
USE epi;
-- 用户表
CREATE TABLE user (
    uid int PRIMARY KEY AUTO_INCREMENT COMMENT '用户名id',
    unick VARCHAR(100) NOT NULL DEFAULT '注册用户' COMMENT '用户昵称',
    uname VARCHAR(100) NOT NULL UNIQUE COMMENT '用户登录',
    upwd VARCHAR(100) NOT NULL COMMENT '用户密码',
    uavatar VARCHAR(300) NOT NULL DEFAULT 'img/avatar/1.jpg' COMMENT '用户头像路径',
    ugender ENUM('未知','男','女') DEFAULT '未知' COMMENT '用户性别',
    islike ENUM('0','1') DEFAULT '0' COMMENT '用户是否加油助力',
    uphone int(11) COMMENT '用户电话号码',
    uaddress VARCHAR(100) COMMENT '用户地址'
);
INSERT INTO user VALUES (null,DEFAULT,'admin','admin',DEFAULT,'未知','0',null,null);
-- 文章表
CREATE TABLE article(
    aid  INT PRIMARY KEY AUTO_INCREMENT COMMENT '文章/视频ID,主键且自增',
    asubject varchar(50) NOT NULL COMMENT '文章/视频标题',
    aconment  VARCHAR(1000) NOT NULL COMMENT '文章正文/视频路径',
    atime    BIGINT NOT NULL COMMENT '文章/视频发布日期',
    aimport  ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '是否置顶',
    type ENUM('文章','视频') NOT NULL COMMENT '类型'
);
INSERT INTO article VALUES (null,'疫情防护——居家防护篇','<p><span>1.体温计、口罩和消毒用品等防疫用品。<br>2.主动做好家庭成员的健康监测,建议早晚测量体温。<br>3.开窗通风,增加室内空气流通,每天2-3次,每次20-30分钟。<br>4.家庭环境以清洁为主,预防性消毒为辅。<br>5.家庭成员不共用毛巾,勤晒衣被;注意个人卫生习惯不随地吐痰,打喷嚏时用纸巾遮住口鼻或采用肘臂遮挡等。<br>6.加强营养,科学饮食,适量运动,保障睡眠,提高身体免疫力。<br>7.从室外返回、咳嗽手捂后、饭前便后应使用洗手液(或肥皂)流水洗手,或用速干手消毒剂揉搓双手。<br>8.不接触、购买和食用野生动物,禽肉蛋要充分煮熟后食用。<br>9.不串门、不聚众、不聚餐、不相互请吃。<br>10.生病时尽量减少外出,不去人员密集场所,外出时佩戴口罩。<br>11.前往人员密集的公共场所,乘坐公共交通工具或与其他人近距离接触时佩戴口罩。<br>12.中、高风险地区,尽量减少不必要的外出;与居家隔离人员共同生活时,应做好清洁消毒,加强个人防护,佩戴口罩。</span><br><img src="https://mmbiz.qpic.cn/mmbiz_jpg/XYkSH2e1UbapUqiayJrsGlibMibYA3QKopbs0S5ZnpO2DNNhcicTu9VONjTF8FRias1HvgIZZysjI4tTegOgTf5R8kQ/640?wx_fmt=jpeg"></p>','21321321321231','1','文章');
INSERT INTO article VALUES (null,'生命的防线mv','video/1.mp4','1223343122312',DEFAULT,'视频');
-- 用户上传动态表
CREATE TABLE dynamic (
    did INT PRIMARY KEY AUTO_INCREMENT COMMENT '动态id',
    dtext VARCHAR(200) NOT NULL COMMENT'动态文本',
    dimg VARCHAR(200) COMMENT '动态图片',
    dtime BIGINT NOT NULL COMMENT '动态发布日期',
    uid INT NOT NULL COMMENT '用户id',
    FOREIGN KEY(uid) REFERENCES user(uid)
);
INSERT INTO dynamic VALUES (null,'今日疫情防护打卡','img/dynamic/1.jpg','1567382190','1');
-- 用户捐献数据表
CREATE TABLE donation(
    did INT PRIMARY KEY AUTO_INCREMENT COMMENT '捐赠物资id',
    dtype ENUM('医用防护','生活用品','粮油副食','其他物品') NOT NULL DEFAULT '医用防护' COMMENT '捐赠类型',
    ddetail VARCHAR(100) NOT NULL COMMENT '捐赠详情',
    dtime BIGINT NOT NULL COMMENT '捐赠时间',
    dstate ENUM('未捐献','未提交','正在审核','待取件','运输中','已完成') DEFAULT '未捐献' COMMENT '捐赠状态',
    uid INT NOT NULL COMMENT '用户id',
    FOREIGN KEY(uid) REFERENCES user(uid)
);
INSERT INTO donation VALUES (null,DEFAULT,'口罩2000个','4564644646464',DEFAULT,'1');
-- 区域数据表
CREATE TABLE region_data (
    pname VARCHAR(50) NOT NULL COMMENT'省份名称',
    cname VARCHAR(50) NOT NULL COMMENT '城市名称',
    confirm INT NOT NULL COMMENT '确诊人数',
    suspect INT NOT NULL COMMENT '疑似人数',
    heal INT NOT NULL COMMENT '治愈人数',
    dead INT NOT NULL COMMENT '死亡人数'
);
-- 国内时段数据表
CREATE TABLE  country_data(
    insert_date VARCHAR(50) NOT NULL UNIQUE COMMENT '数据插入日期',
    confirm INT NOT NULL COMMENT '确诊人数',
    suspect INT NOT NULL COMMENT '疑似人数',
    heal INT NOT NULL COMMENT '治愈人数',
    dead INT NOT NULL COMMENT '死亡人数',
    input INT NOT NULL COMMENT '境外输入人数'
)