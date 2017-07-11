//
//  AppDelegate.h
//  AppDelegateLifecycle
//
//  Created by ttxc on 2017/7/11.
//  Copyright © 2017年 TTXC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

