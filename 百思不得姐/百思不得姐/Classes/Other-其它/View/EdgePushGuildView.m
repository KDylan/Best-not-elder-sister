//
//  EdgePushGuildView.m
//  百思不得姐
//
//  Created by Edge on 2017/4/22.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgePushGuildView.h"

@implementation EdgePushGuildView
+(instancetype)guildViewImage{
    
   EdgePushGuildView *guildView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
 //   guildView.image = [UIImage imageNamed:<#(nonnull NSString *)#>];
    
    guildView.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.75];
    
    return guildView;
}
+(void)showGuildView{
    
        //  拿到版本号
        NSDictionary *info = [[NSBundle mainBundle]infoDictionary];
        NSString *key =@"CFBundleShortVersionString";
        //  当前版本号
        NSString *currentVersion = info[key];
        //  如果这次版本号和上次版本号不同，则升级了，显示引导页
        //  沙盒保存版本号
        NSString *sanBoxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
        
        //  判断
        if (![currentVersion isEqualToString:sanBoxVersion]) {//版本号更新
            EdgePushGuildView *guildView = [EdgePushGuildView guildViewImage];
            guildView.frame = [UIApplication sharedApplication].keyWindow.bounds;
            [[UIApplication sharedApplication].keyWindow addSubview:guildView];
            
            // 新的版本号存入沙盒
            [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
            // 立即存储
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
}
- (IBAction)dissButton:(id)sender {
    
    [self removeFromSuperview];
}

@end
