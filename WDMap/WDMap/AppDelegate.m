//
//  AppDelegate.m
//  WDMap
//
//  Created by wbb on 2021/1/29.
//

#import "AppDelegate.h"
#import "WDBaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
//    self.window.rootViewController = [[WDLaunchViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}





@end
