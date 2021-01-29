//
//  WDFloatingView.m
//  悬浮物
//
//  Created by 施永辉 on 16/6/3.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "AppDelegate.h"
#import "WDFloatingView.h"

//主题颜色

#define MAINCOLOER [UIColor colorWithRed:105/255.0 green:149/255.0 blue:246/255.0 alpha:1]

#define kDownLoadWidth 60

#define kOffSet kDownLoadWidth / 2


@interface WDFloatingView ()<UIDynamicAnimatorDelegate>

//@property (nonatomic , retain ) UIView *backgroundView;//背景视图
//
//@property (nonatomic , retain ) UIImageView *imageView;//图片视图
//
//@property (nonatomic , retain ) UIDynamicAnimator *animator;//物理仿真动画
@end

@implementation WDFloatingView

//初始化

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        //初始化背景视图
        
//        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
//        _backgroundView.layer.cornerRadius = _backgroundView.frame.size.width / 2;
//        
//        _backgroundView.clipsToBounds = YES;
        
//        _backgroundView.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.7];
        
//        _backgroundView.userInteractionEnabled = NO;
//        
//        [self addSubview:_backgroundView];
        
        //初始化图片背景视图
        
//        UIView * imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
//        
//        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
//        
//        imageBackgroundView.clipsToBounds = YES;
//        
//        imageBackgroundView.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.8f];
//        
//        imageBackgroundView.userInteractionEnabled = NO;
//        
//        [self addSubview:imageBackgroundView];
        
       
        
        //初始化图片
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(0);
        }];
        
        [self addTarget:self action:@selector(touchClick)];
        
    }
    
    return self;
    
}
- (void)touchClick {
    if(self.touchBlock) {
        self.touchBlock();
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //返回触摸点坐标
    
    self.startPoint = [startTouch locationInView:self.superview];
    
    // 移除之前的所有行为
    
    [self.animator removeAllBehaviors];

}

//触摸移动

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    
    self.center = [startTouch locationInView:self.superview];
    
}

//结束触摸

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸结束点
    
    UITouch *endTouch = [touches anyObject];
    
    //返回触摸结束点
    
    self.endPoint = [endTouch locationInView:self.superview];
    
    
    
    
    //判断是否移动了视图 (误差范围5)
    
    CGFloat errorRange = 5;
    
    if (( self.endPoint.x - self.startPoint.x >= -errorRange && self.endPoint.x - self.startPoint.x <= errorRange ) && ( self.endPoint.y - self.startPoint.y >= -errorRange && self.endPoint.y - self.startPoint.y <= errorRange )) {
        

        
    } else {
        /**
         inset.left 安全区域距离屏幕最左边的大小
         inset.right 安全区域距离屏幕最右边的大小
         inset.top 安全区域距离屏幕最上边的大小
         inset.bottom 安全区域距离屏幕最下边的大小
         */
        CGFloat topSafe = 0;
        CGFloat leftSafe = 0;
        CGFloat bottomSafe = 0;
        CGFloat rightSafe = 0;
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets insets = self.superview.safeAreaInsets;
            topSafe = insets.top;
            leftSafe = insets.left;
            bottomSafe = insets.bottom;
            rightSafe = insets.right;
            
            UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
            if (orientation == UIInterfaceOrientationLandscapeLeft) {
                topSafe = insets.top;
                leftSafe = 0;
                bottomSafe = insets.bottom;
                rightSafe = insets.right;
            }else if(orientation == UIInterfaceOrientationLandscapeRight){
                
                topSafe = insets.top;
                leftSafe = insets.left;
                bottomSafe = insets.bottom;
                rightSafe = 0;
            }
        }
        
        
        
        //移动
        
        self.center = self.endPoint;
        
        //计算距离最近的边缘 吸附到边缘停靠
        
        CGFloat superwidth = self.superview.bounds.size.width;
        
        CGFloat superheight = self.superview.bounds.size.height;
        
        CGFloat endX = self.endPoint.x;
        
        CGFloat endY = self.endPoint.y;
        
        CGFloat topRange = endY;//上距离
        
        CGFloat bottomRange = superheight - endY;//下距离
        
        CGFloat leftRange = endX;//左距离
        
        CGFloat rightRange = superwidth - endX;//右距离
        
        
        //比较上下左右距离 取出最小值
        
        CGFloat minRangeTB = topRange > bottomRange ? bottomRange : topRange;//获取上下最小距离
        
        CGFloat minRangeLR = leftRange > rightRange ? rightRange : leftRange;//获取左右最小距离
        
        CGFloat minRange = minRangeTB > minRangeLR ? minRangeLR : minRangeTB;//获取最小距离
        
        
        //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
        
        CGPoint minPoint;
        
        if (minRange == topRange) {
            
            //上
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , 0 + kOffSet+topSafe);
            
        } else if(minRange == bottomRange){
            
            //下
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , superheight - kOffSet-bottomSafe);
            
        } else if(minRange == leftRange){
            
            
            
            //左
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(0 + kOffSet+leftSafe , endY);
            
        } else {
            
            //右
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(superwidth - kOffSet-rightSafe , endY);
            
        }
        
        
        //添加吸附物理行为
        
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        
        [attachmentBehavior setLength:0];
        
        [attachmentBehavior setDamping:0.1];
        
        [attachmentBehavior setFrequency:5];
        
        [self.animator addBehavior:attachmentBehavior];
        
        
    }
    
    
}

#pragma mark ---UIDynamicAnimatorDelegate

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    
    
    
}



#pragma mark ---LazyLoading

- (UIDynamicAnimator *)animator
{
    
    if (!_animator) {
        
        // 创建物理仿真器(ReferenceView : 仿真范围)
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        
        //设置代理
        
        _animator.delegate = self;
        
    }
    
    return _animator;
    
}



#pragma mark ---BreathingAnimation 呼吸动画


- (void)HighlightAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundColor = [Self.backgroundColor colorWithAlphaComponent:0.1f];
        
    } completion:^(BOOL finished) {
        
        [Self DarkAnimation];
        
    }];
    
}

- (void)DarkAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundColor = [Self.backgroundColor colorWithAlphaComponent:0.6f];
        
    } completion:^(BOOL finished) {
        
        [Self HighlightAnimation];
        
    }];
    
}


@end
