//
//  WDRequestURL.h
//  NetClass
//
//  Created by wbb on 2020/3/5.
//  Copyright © 2020 WD. All rights reserved.
//

#ifndef WDRequestURL_h
#define WDRequestURL_h

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1  /**开发服务器*/
#define TestSever       0  /**测试服务器**/
#define ProductSever    0  /**生产服务器*/

#if DevelopSever

/**开发服务器*/
#define URL_main       @"http://172.16.2.72"

#elif TestSever

/**测试服务器**/

#define URL_main       @"http://172.16.2.72"

#elif ProductSever

/**生产服务器*/

#define URL_main       @"http://class.xanway.com:1122"

#endif


//MARK: ------------------------------ 登录 ------------------------------
/// 登录接口
static NSString * const WDLoginAPI  = @"/api/v1.0/sysAuth/simple/login";
/// 登出接口
static NSString * const WDLogoutAPI  = @"/api/v1.0/sysAuth/logout";
/// 配置信息
static NSString * const WDConfigAPI = @"/api/v1.0/sysConfig/list";

//MARK: ------------------------------ 我的 ------------------------------
/// 用户信息
static NSString * const WDGetUserInfoAPI  = @"/api/v1.0/userManage/getUserInfo";
/// 修改密码
static NSString * const WDChangeUserInfoAPI  = @"/api/v1.0/userManage/changeUserPwd";


//MARK: ------------------------------ 课程 ------------------------------
/// 课程表（要上的课）
static NSString * const WDLearningCourseAPI = @"/api/v2.0/personalCenter/courseList";

//MARK: ------------------------------ 课件 ------------------------------
/// 课件列表
static NSString * const WDFileListAPI  = @"/api/v1.0/fileManage/list";
/// 搜索课件
static NSString * const WDSearchFileAPI  = @"/api/v1.0/fileManage/search";
/// 课件转换成图片
static NSString * const WDCoursewareImagesAPI  = @"/api/v1.0/fileManage/coursewareImages";


#endif /* WDRequestURL_h */
