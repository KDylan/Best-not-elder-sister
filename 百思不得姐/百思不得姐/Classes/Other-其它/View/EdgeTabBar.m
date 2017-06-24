
//
//  EdgeTabBar.m
//  百思不得姐
//
//  Created by Edge on 2017/4/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeTabBar.h"
#import "EdgePublishViewController.h"
//#import "UIView+EdgeExpention.h"
@interface EdgeTabBar ()
@property(nonatomic,weak)UIButton *publish;
@end

@implementation EdgeTabBar



//  子类用init 重写init方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //  设置全局背景图片
         [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //  创建控件
        UIButton *publish = [[UIButton alloc]init];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publish addTarget:self action:@selector(presentPublish) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:publish];
        self.publish = publish;
    }
    return self;
}
//  发布按钮点击
-(void)presentPublish{
    
    EdgePublishViewController *publishViewController = [[EdgePublishViewController alloc]init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishViewController animated:YES completion:nil ];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //  开始布局子控件
    self.publish.bounds = CGRectMake(0, 0, self.publish.currentBackgroundImage.size.width, self.publish.currentBackgroundImage.size.height);
    self.publish.center = CGPointMake(self.wdith/2, self.height/2);
    
    int index = 0;
    CGFloat W = self.wdith/5;
    CGFloat H = self.height;
    CGFloat Y = 0;
   // CGFloat X =
    
    //  拿出子控件布局
    for (UIView *view in self.subviews) {
        //  拿取类文件NSClassFromString
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
           
            if (index==2) {//  第二个往后跳一个
                index++;
            }
            
            CGFloat X = W * index;
            view.frame = CGRectMake(X, Y, W, H);
            index++;
        }
    }
}
@end
