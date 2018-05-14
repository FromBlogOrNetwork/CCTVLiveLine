//
//  CCLiveViewController.m
//  CCTVLiveLine
//
//  Created by lifu on 14-8-1.
//  Copyright (c) 2014年 中视广信. All rights reserved.
//

#import "CCLiveViewController.h"

@interface CCLiveViewController ()

@end

@implementation CCLiveViewController

@synthesize dicUrl;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
      
    }
    return self;
}

-(id)init
{
    if (self=[super init])
    {
        dicUrl=[[NSDictionary alloc]init];
        [self GetP2PData];
        /*
         *加载的效果;
         */
        //m_HUD= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIImageView *_imageNav=[[UIImageView alloc]init];
    [_imageNav setFrame:CGRectMake(0, IOS7?20:0, 320, 44)];
    [_imageNav setImage:[UIImage imageNamed:@"top"]];
    [_imageNav setUserInteractionEnabled:YES];
    [self.view addSubview:_imageNav];
    
    /*
     * 在线直播demo
     */
    UIButton  *_liveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_liveBtn  setFrame:CGRectMake(10, 7, 75, 30)];
    [_liveBtn setImage:[UIImage imageNamed:@"live"] forState:UIControlStateNormal];
    [_liveBtn addTarget:self action:@selector(PlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_imageNav addSubview:_liveBtn];
    
    
    UILabel *tishi=[[UILabel alloc]init];
    [tishi setFrame:CGRectMake(20, 100, 250, 60)];
    [tishi setBackgroundColor:[UIColor clearColor]];
    [tishi setFont:[UIFont boldSystemFontOfSize:15]];
    tishi.numberOfLines=2;
    [tishi setText:@"提示：在线直播必须保证有网,或者网络状况比较好情况下。。。"];
    [self.view addSubview:tishi];
}

-(void)PlayVideo:(id)sender
{
    if (!dicUrl )
    {
        return;
    }
    //NSLog(@"他不为空==%@",dicUrl);
     AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app PlayVideo:dicUrl];
}

/*
 *获取视频直播
 */

-(void)GetP2PData
{
    CCGetP2PUrl *p2pData=[[CCGetP2PUrl alloc]init];
    [p2pData setDelegate:self];
    [p2pData startPlalyQuest];
}

/*
 * 代理传值
 */

-(void)ReturnGetP2Purl:(BOOL)bRet P2PVideoUrlData:(NSDictionary *)dicVideoUrl
{
    if (!bRet)
    {
        return;
    }
    self.dicUrl=dicVideoUrl;
    
     NSLog(@"dicUrl=%@",self.dicUrl);
}



@end
