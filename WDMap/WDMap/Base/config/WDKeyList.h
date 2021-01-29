//
//  WDKeyList.h
//  NetClass
//
//  Created by wbb on 2020/3/5.
//  Copyright © 2020 WD. All rights reserved.
//

#ifndef WDKeyList_h
#define WDKeyList_h

/// MARK: -------------NSUserDefaults-------------

/// 用户角色
static NSString * const WD_USERROLE = @"WD_USERROLE";
/// 用户token
static NSString * const WD_TOKEN  = @"WD_TOKEN";
/// 用户名称
static NSString * const WD_USERNAME  = @"WD_USERNAME";
/// 用户密码
static NSString * const WD_PASSWORD  = @"WD_PASSWORD";
/// 人脸识别开关
static NSString * const WD_FACEANDTOUCH  = @"WD_FACEANDTOUCH";
/// 登录后设置了人脸识别功能
static NSString * const WD_ISCHOOSEFACE  = @"WD_ISCHOOSEFACE";

/// server_id（服务器IP，进入课程使用）
static NSString * const WD_SERVER_IP  = @"WD_SERVER_IP";

/// realName
static NSString * const WD_REALNAME  = @"WD_REALNAME";

/// MARK: ---------------通知----------------

/// 登陆成功回调
static NSString * const WD_reloadDataSource = @"reloadDataSource";

#endif /* WDKeyList_h */
