//
//  EdgeProcress.m
//  百思不得姐
//
//  Created by Edge on 2017/5/5.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeProcress.h"

@implementation EdgeProcress

-(void)awakeFromNib{
    [super awakeFromNib];
    self.roundedCorners = 2;//  圆角
    self.progressLabel.textColor = [UIColor whiteColor];
}
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{

    [super setProgress:progress animated:animated];
  
     NSString *text =[NSString stringWithFormat:@"%.0f%%",progress*100];
    //  取出‘-’号
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
