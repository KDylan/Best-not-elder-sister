
//
//  EdgeRootTabBarViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeRootTabBarViewController.h"
#import "EdgeEssenceViewController.h"
#import "EdgeNewViewController.h"
#import "EdgeFriendsViewController.h"
#import "EdgeMeViewController.h"
#import "EdgeNavigateViewController.h"
#import "UIImage+UIImage.h"
#import "EdgeTabBar.h"
@interface EdgeRootTabBarViewController ()

@end

@implementation EdgeRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildController];
    
    EdgeTabBar *tabBar = [[EdgeTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
   
    //设置所有应用程序中的UITabBaritem的属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    NSDictionary *selectDict = @{
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
     [item setTitleTextAttributes:selectDict forState:UIControlStateHighlighted];
}

- (void)setUpChildController{
    //  精华
    [self setChildController:[[EdgeEssenceViewController alloc]init] title:@"精华" imageName:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    //  新帖
     [self setChildController:[[EdgeNewViewController alloc]init] title:@"新帖" imageName:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    //  关注
     [self setChildController:[[EdgeFriendsViewController alloc]init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    //  我的
     [self setChildController:[[EdgeMeViewController alloc]init] title:@"我的" imageName:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
     
}
- (void)setChildController:(UIViewController *)ViewController title:(NSString *)title imageName:(NSString *)imageName selectImage:(NSString *)selectImage{
    
//    self.view.backgroundColor = [UIColor
//                                colorWithRed:((float)arc4random_uniform(256)/255.0)
//                                green:((float)arc4random_uniform(256)/255.0)
//                                blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
   
   
    
    EdgeNavigateViewController *nav = [[EdgeNavigateViewController alloc]initWithRootViewController:ViewController];
     ViewController.title = title;
    ViewController.tabBarItem.title = title;
    ViewController.tabBarItem.image = [UIImage imageNamed:imageName];
    ViewController.tabBarItem.selectedImage = [UIImage imageOriginalImaged:selectImage];
    
    [self addChildViewController:nav];
    
}
@end
