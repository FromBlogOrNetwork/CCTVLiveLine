//
//  AppDelegate.h
//  CCTVLiveLine
//
//  Created by lifu on 14-7-31.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow    *window;
@property (nonatomic, retain) Reachability   *reachability;
@property (nonatomic, retain) UIAlertView  *alertView;
@property (nonatomic, retain) NSDictionary *m_DicVideoUrl;
@property (nonatomic,retain ) UINavigationController *navgation;


-(void)PlayVideo:(NSDictionary*)dicVideoUrl;

@end
