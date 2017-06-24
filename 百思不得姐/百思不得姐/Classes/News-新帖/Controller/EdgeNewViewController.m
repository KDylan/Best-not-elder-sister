
//
//  EdgeNewViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeNewViewController.h"
//#import "UIBarButtonItem+EdgeExention.m"
@interface EdgeNewViewController ()

@end

@implementation EdgeNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor= EdgeGloupColor;
    //  设置导航栏图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //  设置左边按钮
    //  不能完成点击切换图片
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:@"MainTagSubIcon" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem iteamWithImageNamed:@"MainTagSubIcon" hightLightImageName:@"MainTagSubIconClick" target:self action:@selector(click)];
}

-(void)click{
    NSLog(@"touch");
}



@end
