# 新项目模板
---

### 功能介绍

模板项目，下载下来，修改Target名字，可以直接当做新项目的脚手架，开启新项目时，直接开始写业务页面

具体用法如下， 描述看不懂的地方 参见 [OC版的AwesomTemplate](https://github.com/maltsugar/AwesomTemplate) 的截图， 和OC版不同的步骤已加粗

1. #####  下载zip 解压之后  删除Awesome_Swift.xcworkspace   Podfile.lock  README.md  3个文件

2. 打开Awesome_Swift.xcodeproj，进入项目， 单击项目名 修改为MyProject,  弹框选择 Rename

3. 点击Target处Manage Schemes,  单机scheme， 修改名称为 MyProject

4. 单机项目名下面的黄色文件夹Awesome_Swift， 右键 Show in Finder , 将文件夹`Awesome_Swift`名称改为 MyProject ,改完之后 进入项目 看到该文件夹下面 所有文件为 浅色

5. 将右边Name改为MyProject， 然后单击文件夹图标，选中刚才改名后的文件夹MyProject

6. Build Settings，选中All  

7. 搜索 info, 双击Info.plist File的值，修改为 `MyProject/Info.plist`

8. #####  搜索 brid, 双击Objective-C Bridging Header的值，修改为 `MyProject/MyProject-Bridging-Header.h`

9. ##### 重名名目录下的Awesome_Swift-Bridging-Header.h文件名 为 `MyProject-Bridging-Header.h`

10. ##### 编辑项目目录下的Podfile  修改target    Awesome_Swift 为 MyProject

11. 退出最外层将文件夹命名为 MyProject

12. ##### cd 到项目目录， 终端输入 pod install ,  等待pod安装完成， 打开 MyProject.xcworkspace  编译通过



