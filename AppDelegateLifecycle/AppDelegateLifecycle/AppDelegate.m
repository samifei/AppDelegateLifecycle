//
//  AppDelegate.m
//  AppDelegateLifecycle
//
//  Created by ttxc on 2017/7/11.
//  Copyright © 2017年 TTXC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - openURL
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    //最新的使用此方法
    if (!url)
    {
        return NO;
    }
    //获取传过来的openURL存到NSUserDefaults
    NSString *URLString = [url absoluteString];
    [[NSUserDefaults standardUserDefaults] setObject:URLString forKey:@"openURL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"URLString:%@",URLString);
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //不用了
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //不用了
    return YES;
}

#pragma mark - 开启程序
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"first"];
        NSLog(@"第一次打开时的操作");
    }else{
        NSLog(@"非第一次打开的操作");
    }
    
    /*
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
         //iOS10特有
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         // 必须写代理，不然无法监听通知的接收与点击
         center.delegate = self;
         [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
             if (granted) {
                 // 点击允许
                 NSLog(@"注册成功");
                 [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                 NSLog(@"%@", settings);
                 }];
             } else {
                 // 点击不允许
                 NSLog(@"注册失败");
             }
         }];
     }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
         //iOS8 - iOS10
         [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
     
     }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
         //iOS8系统以下
         [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
     }
     // 注册获得device Token
     [[UIApplication sharedApplication] registerForRemoteNotifications];
    */

    return YES;
}

#pragma mark - 前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //从后台 进入前台
    NSLog(@"applicationWillEnterForeground - 前台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //每次开启程序都执行，活跃状态
    NSLog(@"applicationDidBecomeActive -活跃");
}

#pragma mark - 后台
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    //发送应用程序时将从活跃不活跃的状态。这可能发生某些类型的暂时中断(如电话来电或短信)或当用户退出应用程序开始转换到背景状态。
    //使用这种方法暂停正在进行的任务,禁用计时器,和无效的图形渲染回调。游戏应该使用这个方法来暂停游戏。
    
    
    NSLog(@"applicationWillResignActive -不活跃");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //使用此方法来释放共享资源,保存用户数据,无效计时器,和储存足够多的应用程序状态信息来恢复您的应用程序的当前状态,以防它终止后。
    //如果您的应用程序支持后台执行,而不是调用此方法applicationWillTerminate:当用户退出。
    
    NSLog(@"applicationDidEnterBackground - 后台");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //你可以在Info.plist里设置Application does not run in background(不在后台运行)为YES.点Home直接关闭程序，而不是后台挂起。
    //当应用退出，并且进程即将结束时会调到这个方法，一般很少主动调到，更多是内存不足时是被迫调到的，我们应该在这个方法里做一些数据存储操作。
    NSLog(@"applicationWillTerminate - 关闭程序");
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //当应用可用内存不足时，会调用此方法，在这个方法中，应该尽量去清理可能释放的内存。如果实在不行，可能会被强行退出应用。
}

#pragma mark - Notification Delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}
#pragma mark - ios10以下 
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //当应用在前台运行中，收到远程通知时(不会弹出系统通知界面)，会回调这个方法。
    //当应用在后台状态时，点击push消息启动应用，也会回调这个方法。
    //当应用完全没有启动时，点击push消息启动应用，就不会回调这个方法。
    //ios 10后使用UNUserNotification
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notificatio{
//    如果在前台运行状态直接调用
//    如果在后台状态，点击通知启动时，也会回调这个方法
//    当应用完全没有启动时，点击push消息启动应用，就不会回调这个方法。
//    ios 10后使用UNUserNotification
}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    // 通知的点击事件
}
@end
