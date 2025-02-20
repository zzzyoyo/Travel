# Share Your Travel 项目说明文档
___
## 使用技术
+ **J2EE：**  
JSP、Servlet、JDBC、javaBean
+ **面向对象设计思想：**  
将业务逻辑中的实体对象抽象成程序中的类，对这些类进行CRUD操作
+ **MVC和DAO设计模式：**  
项目分为model、view和controller三个部分，jsp负责负责显示页面，即view，servlet负责获取前端参数，调用相关方法，对前端做出响应，即controller，Dao类负责对Javabean类实现一系列特定操作，抽象对数据库的增删改查，即model
+ **网页脚本语言：**  
jquery、ajax
+ **网页开发框架：**  
boostrap  
+ **数据库：**  
MySQL  


## 需求来源：课程PJ文档
## 实现功能
* **基础功能：**  
	文档所要求的全部基础功能
* **进阶功能：**  
	1. 详情页面图片局部放大功能  
	2. 注册与登录验证码功能
	3. 用户可以对图片评论并按照时间和热度显示在详情页
	4. 高级、全面的模糊搜索:*（可动态改变搜索的相似度，从0到100%，例如50%，则可以搜索出包含搜索内容一半及以上字符的图片）*  
	
## 项目结构
- **out**:项目的输出目录，即部署在服务器上的完整资源，打包成war的发布包artifact
- **src**:java源文件
	- **contextListener**:服务器监听类，监听服务器的初始化和关闭，负责在重新部署的时候关闭DataSource等资源
	- **dao**:数据操作对象，负责对数据库的CRUD操作
	- **domain**:数据实体对象，即数据表到java类的映射
	- **functionPackage**:一些工具类，如MD5加密、反射、文件操作等
	- **jdbcUtils**:jdbc工具类，提供数据库连接和关闭方法
	- **servlet**:负责前后端的通信
- **web**:项目源文件
	- **index.jsp等jsp文件**:前端页面文件
	- **WEB-INF**
		- **classes**:scr文件夹中的java源文件的输出目录，即.class文件
		- **JSPFiles**:不能给客户端直接访问的jsp文件，如用作组件的navigation.jsp，或者用来展示错误信息的error.jsp
		- **lib**:库文件，包含了所有项目所需jar包
		- **web.xml**:项目配置文件
	- **resources**:静态资源文件，如图片、css、js等  
	
## 关于前后端分离
该项目采取了前后端分离的思想，但是没有做到真正的前后端分离开发，即前后端属于同一个项目，部署在一起。jsp负责前端，支持HTML、css、js等语言，通过ajax和后端的servlet进行不刷新页面的异步通信，或者通过url跳转再重定向进行刷新页面的通信，后端用java实现，负责操作数据库以及给前端提供所需的数据。

## [项目GitHub地址](https://github.com/zzzyoyo/Travel/)

## 写在最后
本次pj时间比较紧张，还有许多不完善的地方，结构也不够清晰，等有时间再重构一下，并且实现实时聊天功能。



