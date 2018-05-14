//
//  CCLiveViewController.h
//  CCTVLiveLine
//
//  Created by lifu on 14-8-1.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGetP2PUrl.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface CCLiveViewController : UIViewController<CCGetP2PUrlDelegate>{
    
    MBProgressHUD          *m_HUD;
    
}

@property (nonatomic, retain) NSDictionary    *dicUrl;

-(void)GetP2PData;

@end
