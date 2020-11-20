# JLU_HTML5_Groupwork
## 2020年吉林大学HTML5课程第三组小组作业
    Our work will be submitted here!
    
## 1 产品简单说明    
-------------

### 1.1 功能说明
    1. 具有日历功能
    2. 在日历功能的基础上添加todolist功能
    3. 实现当日天气查询功能
-------------

### 1.2 分工说明

    1.具体功能实现由Xutw负责
    2.具体逻辑页面过度和UI优化由Lxz负责
    3.产品方面由Fsm负责
------------------------------->from Xutw 2020.11.9</br>

    4.真机测试与PPT讲稿由Zbj负责
------------------------------->from Xutw 2020.11.20</br>

## 2 更新日志
------------

### 2020.11.1
    1. 添加了日历主体，向产品经理说明了本产品的基本功能与受众目标

 <div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/%E6%97%A5%E5%8E%86%E4%B8%BB%E4%BD%93.jpg" alt="日历主题样式" width="300" height="300" />
 </div>

#### 需求分析

    该APP的目标用户分为两类

##### 1.工作学习群体

    该类群体用户年龄集中在18~40岁。
    特点是工作学习业务较为繁重。
    在每日上班前需要便捷的方式同时查看本日天气和需要做的工作。
    平日工作学习时，也需要快速记录需要做的工作。
    在出差时，有查看当地那天气的需求。

##### 2.老年群体

    该类群体用户年龄集中在55岁以上。
    特点是对互联网的接受程度不高，难以使用复杂且多样的APP。
    对产品的简单实用性需求极强。
    为此本产品在设计上将多种功能进行了集合，并精简操作步骤，易于使用。

### 2020.11.9

    功能实现：
        1. 实现了简单的Todolist 备忘录的功能

 <div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/%E5%A4%87%E5%BF%98%E5%BD%95%E5%8A%9F%E8%83%BD.png" alt="备忘录todolist功能" width="600" height="450" />
 </div>

    下一步方向：
        1.需要将日历的每一天与每一个Todolist功能实现起来。
        2.实现天气查询功能

### 2020.11.18

    功能实现：
        1.实现了天气查询功能
        实现细节：通过openweathermap的天气api 申请返回数据后JSON解码。
        2.实现了三个功能页面的过渡与切换。

 <div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/%E6%97%A5%E5%8E%86%2B%E5%A4%A9%E6%B0%94%E5%8A%9F%E8%83%BD.jpg" alt="日历+天气功能" width="300" height="630" />
 </div>

    优化方向：
        1.日历的每一天绑定一个Todolist界面
        2.优化天气的查询

### 2020.11.18

    优化：
        1优化了天气的查询：
            APP无需申请地理位置权限，自动记录你上一次输入的城市，然后查询天气。
    尚未实现：
        1.日历的每一天绑定一个Todolist （下次一定）

## 3 使用说明书

-------------------

### 3.1 软件概述

#### 3.1.1 软件用途
    产品整体分为两个主要界面，涵盖了日历，天气，备忘录三个主要功能。

#### 3.1.2 运行环境
    硬件：iPhone6及以上机型
    操作系统：IOS 10及以上版本

#### 3.1.3 日历图标

<div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/app%E5%9B%BE%E6%A0%87.png" width="300" height="300" />
 </div>

    本APP的logo设计以白色作为底色，上布黑色时钟日历图案。
    突出了简洁，易用的特点，又成功使用户直观了解app用途，在整体视觉上非常统一。
 
### 3.2 首页

 <div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/%E6%97%A5%E5%8E%86%2B%E5%A4%A9%E6%B0%94%E5%8A%9F%E8%83%BD.jpg" alt="日历+天气功能" width="300" height="630" />
 </div>

    将日历于天气合二为一，放置在进入app的系统界面，使用户在最短时间内直观看到日期状况。
    在日期下方，可以通过输入城市，获得城市当前天气状况，主色调选取黑色，使页面同备忘录页面有了显著区分。

#### 3.2.1 日历

    所见即所得 它是个日历 但又不仅仅是个日历。（点击日历进入备忘录页面）

#### 3.2.2 天气

    1.手机下端详细显示当前时刻的天气数据。（ps:最高最低是估计当前时刻的最高最低温度 而不是整天。）
    2.在日历主体的上端有更改城市输入栏 输入后 点击天气显示板块的上端更改城市，即可更换城市，显示其天气数据。

### 3.3 备忘录页面

 <div align=center>
 <img src="https://github.com/Stephenxu000/JLU_HTML5_Groupwork/blob/main/picture/%E5%A4%87%E5%BF%98%E5%BD%95%E5%8A%9F%E8%83%BD.png" alt="备忘录todolist功能" width="600" height="450" />
 </div>

    备忘录界面选用白的作为基底，使用户能清晰明了的看到总体的工作事项。
    加以修改，添加，删除功能。
    点击右上方add按钮即可进入备忘录编辑页面进行事项编写，再点击页面下放save健即可进行保存。

#### 3.3.1 备忘录
  1.备忘录具有三个页面组成 分别是添加任务页面 显示任务页面 修改删除任务页面。
  2.按钮即功能描述。
