//
//  WDFloatingView.h
//  悬浮物
//
//  Created by 施永辉 on 16/6/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol WDFloatingViewDelegate <NSObject>

//@required
//- (void)clickEvent;
//@end

typedef void (^TouchBlock) (void);
@interface WDFloatingView : UIView

//@property(nonatomic, assign) id<WDFloatingViewDelegate> delegate;

@property (nonatomic ,assign) CGPoint startPoint;//触摸起始点

@property (nonatomic ,assign) CGPoint endPoint;//触摸结束点

@property (nonatomic ,copy) TouchBlock touchBlock;

@property (nonatomic , retain ) UIView *backgroundView;//背景视图

@property (nonatomic , retain ) UIImageView *imageView;//图片视图

@property (nonatomic , retain ) UIDynamicAnimator *animator;//物理仿真动画
@end
