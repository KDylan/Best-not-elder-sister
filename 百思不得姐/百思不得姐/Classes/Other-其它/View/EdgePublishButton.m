 //
//  EdgePublishButton.m
//  百思不得姐
//
//  Created by Edge on 2017/5/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgePublishButton.h"

@implementation EdgePublishButton


// init代码来到这里
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}
//  XIB创建来这里
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUP];
}

-(void)setUP{
    //  初始化代码
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
}
//  自己fream变化就会来到这里
-(void)layoutSubviews{
    [super layoutSubviews];
    //  图片布局
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.wdith = self.wdith;
    self.imageView.height = self.imageView.wdith;
    //  布局文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.wdith = self.wdith;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
