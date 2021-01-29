//
//  WDToolBar.h
//  NetClass
//
//  Created by wbb on 2020/3/10.
//  Copyright © 2020 WD. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "WDBaseView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ViewHeightBlock)(float height);
typedef void(^SendMessageBlock)(NSString *str);

@interface WDToolBar : WDBaseView

/// 自适应高度回调
@property (nonatomic,copy) ViewHeightBlock viewHeightBlock;

/// 发送消息回调
@property (nonatomic,copy) SendMessageBlock sendMessageBlock;

/// 背景view
@property (nonatomic,strong) UIView *backView;

/// 消息栏
@property (nonatomic,strong) UITextView *textView;
@end

NS_ASSUME_NONNULL_END
