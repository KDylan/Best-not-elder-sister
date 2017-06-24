//
//  EdgePicture.m
//  百思不得姐
//
//  Created by Edge on 2017/5/4.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgePicture.h"
#import "EdgeShowPictureController.h"
#import "EdgeProcress.h"
@interface EdgePicture ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;//  gif

@property (weak, nonatomic) IBOutlet UIImageView *imageView;//  图片内容

@property (weak, nonatomic) IBOutlet UIButton *seeBigView;//  查看大图
@property (weak, nonatomic) IBOutlet EdgeProcress *procress;//  图片下载进度
/* 图片的高度约束 **/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *p_height;
@end

@implementation EdgePicture

+(instancetype)loadPictureXib{

    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
//  关闭自动布局
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
       //  让图片开启交互
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture) ]];
}
//  全屏显示图片
-(void)showPicture{
 //   NSLog(@"%s",__func__);
//  加载XIB
    EdgeShowPictureController *showPictureView = [[EdgeShowPictureController alloc]init];
    //  传递数据
    showPictureView.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureView animated:YES completion:nil];
}


-(void)setTopic:(EdgeTopics *)topic{
    _topic = topic;
    //  显示进度值
    [self.procress setProgress:topic.pictureProgress animated:YES];
    //  是不是加载完成
    self.procress.hidden = topic.isLoadImageFinish;
    //  设置中间内容图片
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:topic.imageurl] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {//下载进度
        
       topic.loadImageFinish = NO;
         self.procress.hidden = NO;
        
        topic.pictureProgress = 1.0*receivedSize/expectedSize;
        
        [self.procress setProgress:topic.pictureProgress animated:YES];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//下载完成
        
        self.procress.hidden = YES;
         topic.loadImageFinish = YES;
        if (error) {
            
            [SVProgressHUD dismissWithDelay:1.5];

            [SVProgressHUD showErrorWithStatus:@"图片加载失败"];
        }
           }];
    //  gif标识显示隐藏
    self.gifView.hidden = !topic.gif;
     self.p_height.constant= (ScreenWidth-40)*topic.height/topic.width;
    //  判断大图
       if (topic.isBigPicture) {// 大图处理
           self.seeBigView.hidden = NO;
            //self.imageView.contentMode = UIViewContentModeTop;//内容模式
           self.imageView.clipsToBounds = YES;//  裁剪多余部分
       }else{//  不是大图
           self.seeBigView.hidden = YES;
       }
}
@end
