
//
//  UIBarButtonItem+EdgeExention.m
//  百思不得姐
//
//  Created by Edge on 2017/4/22.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UIBarButtonItem+EdgeExention.h"

@implementation UIBarButtonItem (EdgeExention)
+(instancetype)iteamWithImageNamed:(NSString *)imageName hightLightImageName:(NSString *)hightNamed target:(id)target action:(SEL)action{
    //  自定义点按view
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightNamed] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, btn.currentImage.size.width, btn.currentImage.size.height);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
