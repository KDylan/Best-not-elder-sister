
//
//  EdgeMeViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeMeViewController.h"
//#import "UIBarButtonItem+EdgeExention.m"
@interface EdgeMeViewController ()

@end

@implementation EdgeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor= EdgeGloupColor;
   self.navigationItem.title = @"我的";
    
    //  设置右边按钮
    
    UIBarButtonItem *moonitem = [UIBarButtonItem iteamWithImageNamed:@"mine-moon-icon" hightLightImageName:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    UIBarButtonItem *settingitem = [UIBarButtonItem iteamWithImageNamed:@"mine-setting-icon" hightLightImageName:@"mine-setting-icon-click" target:self action:@selector(settingClick)];

    
    
    self.navigationItem.rightBarButtonItems = @[settingitem,moonitem];
}

-(void)moonClick{
    NSLog(@"%s",__func__);
}
-(void)settingClick{
    NSLog(@"%s",__func__);
}

@end
