//
//  WDBaseTabBarController.m
//  Class
//
//  Created by wbb on 2020/3/3.
//  Copyright © 2020 WD. All rights reserved.
//

#import "WDBaseTabBarController.h"
#import "WDMoreVC.h"
#import "WDClassVC.h"
#import "WDCourseVC.h"
#import "WDBaseNavigationController.h"
#import "WDFaceFingerprintView.h"
#import "WDBiometryView.h"

@interface WDBaseTabBarController ()
@property (nonatomic, strong) WDFaceFingerprintView *faceView;
@property (nonatomic, strong) WDBiometryView *biometryView;

/** 当前索引 */
@property (nonatomic, assign) NSInteger currentIndex;
/** TabBar上的ImageViewArray */
@property (nonatomic, copy) NSArray *tabBarImageVArray;

@end

// tabBarItem数量
static const CGFloat itemCount = 3;

@implementation WDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.tintColor = main_select_text_color;
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    [self addTabBarVC:[[WDCourseVC alloc] init] withTitle:@"课表" withNormalImage:@"course_tabbar_normal" withSelectImage:@"course_tabbar_select"];
    [self addTabBarVC:[[WDClassVC alloc] init] withTitle:@"上课" withNormalImage:@"class_tabbar_normal" withSelectImage:@"class_tabbar_select"];
    [self addTabBarVC:[[WDMoreVC alloc] init] withTitle:@"我的" withNormalImage:@"more_table_normal" withSelectImage:@"more_table_select"];
    
    if ([WDGlobal isLogin]&&[[WDUtil getInfoForKey:WD_ISCHOOSEFACE] boolValue]) {
        self.faceView.hidden = NO;
    }
    
    if ([WDGlobal isLogin] && ![[WDUtil getInfoForKey:WD_ISCHOOSEFACE] boolValue] && [[WDUtil getInfoForKey:WD_FACEANDTOUCH] boolValue] && ![WDUtil shareInstance].isFaceBackLogin) {
        self.biometryView.hidden = NO;
    }
}

- (void)addTabBarVC:(UIViewController *)viewController withTitle:(NSString *)title withNormalImage:(NSString *)normalImage withSelectImage:(NSString *)selectImage {
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:hexColor(2481ff)} forState:UIControlStateSelected];
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    viewController.tabBarItem.title = title;
    WDBaseNavigationController *nav = [[WDBaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}
- (WDFaceFingerprintView *)faceView {
    if (!_faceView) {
        _faceView = [[[NSBundle mainBundle] loadNibNamed:@"WDFaceFingerprintView" owner:nil options:nil] lastObject];
        _faceView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREENH_HEIGHT);
        [self.view addSubview:_faceView];
    }
    return _faceView;
}
- (WDBiometryView *)biometryView {
    if (!_biometryView) {
        _biometryView = [[[NSBundle mainBundle] loadNibNamed:@"WDBiometryView" owner:nil options:nil] lastObject];
        _biometryView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREENH_HEIGHT);
        [self.view addSubview:_biometryView];
    }
    return _biometryView;
}

/** 点击tabbarItem自动调用 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != _currentIndex) {
        // 不需要重复添加
        if (self.tabBarImageVArray.count == 0) {
            self.tabBarImageVArray = [self throughTabBarSubviewsMakeUpImageArray];
        }
        [self animationWithIndex:index];
        _currentIndex = index;
    }
}

/** 遍历，将TabBar上需要动画的控件集合成数组 */
- (NSArray *)throughTabBarSubviewsMakeUpImageArray {
    
    NSMutableArray *imageMuArr = [NSMutableArray arrayWithCapacity:itemCount];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            /** 这一层for循环分离UITabBarButton中的imageV和label两个Subview，目的是只让图片有动画效果，或者只让文字有动画效果 */
            // 当前只让图片有动画效果
            for (UIImageView *barImageV in tabBarButton.subviews) {
                if ([barImageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    [imageMuArr addObject:barImageV];
                }
            }
        }
    }
    return [imageMuArr mutableCopy];
}

/**
 * 图片动画
 
 * CABasicAnimation类的使用方式就是基本的关键帧动画。
 * 所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
 */
- (void)animationWithIndex:(NSInteger)index {
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.9];
    pulse.toValue = [NSNumber numberWithFloat:1.1];
    UIImageView *animalImageV = self.tabBarImageVArray[index];
    [animalImageV.layer addAnimation:pulse forKey:nil];
}

- (NSArray *)tabBarImageVArray {
    if (!_tabBarImageVArray) {
        _tabBarImageVArray = [NSArray array];
    }
    return _tabBarImageVArray;
}

@end
