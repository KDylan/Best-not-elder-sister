//
//  EdgeVedioView.m
//  百思不得姐
//
//  Created by Edge on 2017/5/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeVedioView.h"
#import "EdgeTopics.h"
#import "EdgeShowPictureController.h"
@interface EdgeVedioView()
@property (weak, nonatomic) IBOutlet UIImageView *vedioImageView;//  视频图片
@property (weak, nonatomic) IBOutlet UILabel *vedioPlayCount;//  播放次数
@property (weak, nonatomic) IBOutlet UILabel *vedioTime;//  视频时间
@property (weak, nonatomic) IBOutlet UIButton *vedioPlay;//  播放

@end

@implementation EdgeVedioView

+(instancetype)loadVedioXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //  让图片开启交互
    self.vedioImageView.userInteractionEnabled = YES;
    [self.vedioImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture) ]];
}

//  全屏显示图片
-(void)showPicture{
    //   NSLog(@"%s",__func__);
    //  加载XIB
    EdgeShowPictureController *showPictureView = [[EdgeShowPictureController alloc]init];
    //  传递数据
    showPictureView.topic = self.vediotopic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureView animated:YES completion:nil];
}

-(void)setVediotopic:(EdgeTopics *)vediotopic{
    _vediotopic = vediotopic;
    [self.vedioImageView sd_setImageWithURL:[NSURL URLWithString:vediotopic.cdn_img]];
    //  设置播放次数
    self.vedioPlayCount.text = [NSString stringWithFormat:@"%zd次",vediotopic.playcount];
    //  设置时长
    NSInteger minute = vediotopic.voicetime/60;
    NSInteger second = vediotopic.voicetime%60;
    self.vedioTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}

@end
