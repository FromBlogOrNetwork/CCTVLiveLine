//
//  AppDelegate.m
//  CCTVLiveLine
//
//  Created by lifu on 14-7-31.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "CCLiveViewController.h"
#import "CCPlayViewController.h"

@implementation AppDelegate
@synthesize reachability;
@synthesize alertView;
@synthesize m_DicVideoUrl;
@synthesize navgation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //检测网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
												 name:kReachabilityChangedNotification object:nil];
	self.reachability = [Reachability reachabilityForInternetConnection];
	[reachability startNotifier];
    
    CCLiveViewController *_CClive=[[CCLiveViewController alloc]init];
    navgation=[[UINavigationController alloc]initWithRootViewController:_CClive];
    navgation.navigationBarHidden=YES;
    self.window.rootViewController=navgation;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)reachabilityChanged: (NSNotification* )notification
{
	Reachability* curReach = [notification object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    NSString *statusString= @"";
    
	if(NotReachable == netStatus) //
	{
		statusString = NSLocalizedString(@"No network connection, please check your network settings.", @"Network connection failed.");
		UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOTICE", @"Notice title") message:statusString delegate:nil
												  cancelButtonTitle:NSLocalizedString(@"OK", @"OK button") otherButtonTitles:nil];
		[alertView1 show];
        
	}
	else if(ReachableViaWiFi||ReachableViaWWAN == netStatus)
	{
		UIAlertView *alertView2 = [[UIAlertView alloc]initWithTitle:@"NOTICE"
														   message:@"Connection has been restored. Please refresh."
														  delegate:nil
												 cancelButtonTitle:@"OK"
												 otherButtonTitles:nil];
		[alertView2 show];
	}
}


/*
 * 播放视频
 */
-(void)PlayVideo:(NSDictionary *)dicVideoUrl
{
    //当前网络状况
    NetworkStatus netStatus=[reachability  currentReachabilityStatus];
    
    if (!dicVideoUrl)
    {
        return;
    }
    
    if (netStatus==ReachableViaWWAN)
    {
         alertView= [[UIAlertView alloc]initWithTitle:@"NOTICE"
                                                    message:@"You're using 3G mode. Wifi network is recommended. Continue browsing?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Continue",nil];
		[alertView show];
        
    }
    else if (netStatus==ReachableViaWiFi)
    {
        self.m_DicVideoUrl=dicVideoUrl;
        
        NSLog(@"%@",m_DicVideoUrl);
        
        NSString *_urlIPad=[m_DicVideoUrl objectForKey:@"ipad"];
        
        NSLog(@"_urlIPad=%@",_urlIPad);
        
        if (!_urlIPad||0==[_urlIPad length])
        {
            return;
        }
        
        CCPlayViewController *_play=[[CCPlayViewController alloc]initWithVideoUrl:_urlIPad andIsDetail:NO];
        [navgation presentViewController:_play animated:YES completion:^{ }];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
