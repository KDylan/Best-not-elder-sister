
//
//  EdgeFriendsViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeFriendsViewController.h"
//#import "UIBarButtonItem+EdgeExention.m"
@interface EdgeFriendsViewController ()

@end

@implementation EdgeFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor= EdgeGloupColor;
    self.navigationItem.title = @"我的关注";
    //  自定义点按view
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem iteamWithImageNamed:@"friendsRecommentIcon" hightLightImageName:@"friendsRecommentIcon-click" target:self action:@selector(click)];
    
    
}

-(void)click{
    NSLog(@"touch");
}

@end
