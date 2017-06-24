
//
//  EdgeNavigateViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeNavigateViewController.h"

@interface EdgeNavigateViewController ()

@end

@implementation EdgeNavigateViewController
//  当第一次来到这个类进行调用（做类初始化最好）
+(void)initialize{
    //  设置全局导航栏图片
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];//  选择哪一个类进行设置
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //  设置判断
    if (self.childViewControllers.count > 0) {
        
        //  隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      //  [btn setBackgroundColor:[UIColor redColor]];
         btn.size = CGSizeMake(100, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
       
        //  内容靠左显示
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //  设置内边距
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        
        [ btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [ btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
        
       
        
         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
     
    [super pushViewController:viewController animated:animated];
   
}
-(void)backToView{
    [self popViewControllerAnimated:YES];
}
@end
