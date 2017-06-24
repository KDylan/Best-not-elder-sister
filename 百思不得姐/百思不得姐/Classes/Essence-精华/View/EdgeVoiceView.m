//
//  EdgeVoiceView.m
//  百思不得姐
//
//  Created by Edge on 2017/5/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeVoiceView.h"
#import "EdgeTopics.h"
#import "EdgeShowPictureController.h"
@interface EdgeVoiceView()
//  内容图片
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
//  播放次数
@property (weak, nonatomic) IBOutlet UILabel *voicePlayCount;
//  播放时长
@property (weak, nonatomic) IBOutlet UILabel *voicePlayTime;
//  播放
@property (weak, nonatomic) IBOutlet UIButton *voicePlay;

@end
@implementation EdgeVoiceView

+(instancetype)loadVoiceXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
//  关闭自动布局
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //  让图片开启交互
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture) ]];
}
//  全屏显示图片
-(void)showPicture{
    //   NSLog(@"%s",__func__);
    //  加载XIB
    EdgeShowPictureController *showPictureView = [[EdgeShowPictureController alloc]init];
    //  传递数据
    showPictureView.topic = self.voicetopic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureView animated:YES completion:nil];
}


-(void)setVoicetopic:(EdgeTopics *)voicetopic{
    
    _voicetopic = voicetopic;
    
    //  设置中间内容声音
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:voicetopic.imageurl]];
    //  设置播放次数
    self.voicePlayCount.text = [NSString stringWithFormat:@"%zd次",voicetopic.playcount];
    //  设置时长
    NSInteger minute = voicetopic.voicetime/60;
    NSInteger second = voicetopic.voicetime%60;
    self.voicePlayTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
