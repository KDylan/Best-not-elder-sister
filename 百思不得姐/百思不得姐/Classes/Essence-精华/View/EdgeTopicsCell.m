//
//  EdgeTopicsCell.m
//  百思不得姐
//
//  Created by Edge on 2017/5/3.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeTopicsCell.h"
#import "EdgeTopics.h"
#import "EdgePicture.h"
#import "EdgeVoiceView.h"
#import "EdgeVedioView.h"
@interface EdgeTopicsCell()
//  头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//  昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *Sina_v;//  Z新浪会员
@property (weak, nonatomic) IBOutlet UILabel *text_Label;//  文字内容
//  图片帖子
@property(weak,nonatomic)EdgePicture *pictureView;
//  声音帖子
@property(weak,nonatomic)EdgeVoiceView *VoiceView;
//  视频帖子
@property(weak,nonatomic)EdgeVedioView *vedioView;

@end
@implementation EdgeTopicsCell

-(EdgeVedioView *)vedioView{
    if (!_vedioView) {
        EdgeVedioView *vedioView = [EdgeVedioView loadVedioXib];
        [self.contentView addSubview:vedioView];
        _vedioView = vedioView;
    }
    return _vedioView;
}
-(EdgeVoiceView *)VoiceView{
    if (!_VoiceView) {
        EdgeVoiceView *voiceView = [EdgeVoiceView loadVoiceXib];
        [self.contentView addSubview:voiceView];
        _VoiceView = voiceView;
    }
    return _VoiceView;
}

-(EdgePicture *)pictureView{
    if (!_pictureView) {
        EdgePicture *pictureView = [EdgePicture loadPictureXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
  //  设置背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage resiziable:@"mainCellBackground"]];
}

//  重写set方法

-(void)setTopics:(EdgeTopics *)topics{
    
    _topics = topics;
    //  设置帖子内容
    self.text_Label.text = topics.text;
    //  设置会员
    self.Sina_v.hidden = !topics.isSina_V;

    //  设置数据
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topics.name;
    //  设置时间
    self.timeLabel.text = topics.create_time;
    
    [self setBtnTitle:self.dingBtn count:topics.ding placehodel:@"顶"];
    
    [self setBtnTitle:self.caiBtn count:topics.cai placehodel:@"踩"];
    
    [self setBtnTitle:self.shareBtn count:topics.repost placehodel:@"分享"];
    
    [self setBtnTitle:self.commentBtn count:topics.comment placehodel:@"评论"];
    
      // 根据类型判断不是图片那么久显示图片控件
//    if (topics.type != EdgeTopicWord) {//  判断是不是段子
//        //  将模型给picture
//        self.pictureView.topic = topics;
//        
//        self.pictureView.frame = topics.pictureViewFream;
//        
//    }
//    if (!topics.imageurl) {//  判断段子
//        self.pictureView.hidden = YES;
//    }else{
//        self.pictureView.hidden = NO;
//    }

    //  判断类型
    switch (topics.type) {
            //  所有
        case EdgeTopicAll:
            
            break;
            //  图片
        case EdgeTopicPicture:
        {
            self.pictureView.hidden = NO;
            self.VoiceView.hidden = YES;
            self.vedioView.hidden = YES;
            //  将模型给picture
            self.pictureView.topic = topics;
            //  设置图片控件大小
            self.pictureView.frame = topics.pictureViewFream;
        }
            break;
            //  声音
        case EdgeTopicVoice:
        {
            self.pictureView.hidden = YES;
            self.VoiceView.hidden = NO;
            self.vedioView.hidden = YES;
            self.VoiceView.frame = topics.voiceViewFream;
            
            self.VoiceView.voicetopic = topics;
        }
            break;
            //  视频
        case EdgeTopicVedio:
        {
            self.pictureView.hidden = YES;
            self.VoiceView.hidden = YES;
            self.vedioView.hidden = NO;
            self.vedioView.frame = topics.VedioViewFream;
            self.vedioView.vediotopic = topics;
        }
            break;
            //  段子
        case EdgeTopicWord:
        {
            //  隐藏控件
            self.pictureView.hidden = YES;
            self.VoiceView.hidden = YES;
            self.vedioView.hidden = YES;
        }
            break;
            
        default:
            break;
    }

}
//设置工具条文字
-(void)setBtnTitle:(UIButton *)btn count:(NSInteger)count placehodel:(NSString *)placehodel{
    NSString *title = nil;
    if(count==0){
        title = placehodel;
    }
    else if (count > 9999) {
        title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        title = [NSString stringWithFormat:@"%zd",count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
//  重写fream
-(void)setFrame:(CGRect)frame{
    frame.size.height-= 10;
     frame.size.width-= 10;
    frame.origin.y+= 10;
     frame.origin.x+= 5;
    [super setFrame:frame];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//  时间练习
//-(void)timeText{
//   
//    NSString *time = creat_Time;
//    
//    //  获取当前时间
//    NSDate *now = [NSDate date];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *creatTime = [fmt dateFromString:creat_Time];
//    //  时间比较(时间差：秒)
//    // NSTimeInterval datele = [now timeIntervalSinceDate:creatTime];
//    
//    //  日历类
//    NSCalendar *calend = [NSCalendar currentCalendar];//  单例
//    //    NSInteger year = [calend component:NSCalendarUnitYear fromDate:now];//  年
//    //     NSInteger month = [calend component:NSCalendarUnitMonth fromDate:now];//  月
//    //     NSInteger day = [calend component:NSCalendarUnitDay fromDate:now];//  日
//    
//    NSDateComponents *creat_Cmps = [calend components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:creatTime];
//    
//    NSDateComponents *now_Cmps = [calend components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:now];
//    
//
//}
@end
