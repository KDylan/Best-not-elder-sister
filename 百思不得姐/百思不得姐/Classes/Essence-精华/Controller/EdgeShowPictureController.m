//
//  EdgeShowPictureController.m
//  百思不得姐
//
//  Created by Edge on 2017/5/5.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeShowPictureController.h"
#import "EdgeTopics.h"
#import "EdgeProcress.h"
@interface EdgeShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet EdgeProcress *progressView;

@end

@implementation EdgeShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  显示进度值
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //  添加图片
    UIImageView *imageView = [[UIImageView alloc]init];
    
    self.imageView = imageView;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(backButton:)]];
    
     [self.scrollView addSubview:imageView];
    //  图片尺寸
    imageView.wdith = ScreenWidth;
    //  图片高度
    //  W/H=w/h
  imageView.height = self.topic.height/self.topic.width * imageView.wdith;
    
       if (imageView.height > ScreenHeigth) {
        imageView.x = 0;
        imageView.y = 0;
        self.scrollView.contentSize = CGSizeMake(0, imageView.height);//  滚动间距
          // self.scrollView.height = imageView.height;
    }else{
        imageView.x = 0;
        imageView.centery = ScreenHeigth/2;// 居中
    }
    [imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:self.topic.imageurl] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
//  保存下载图片进度
       self.topic.pictureProgress = receivedSize/expectedSize * 1.0;
        
        [self.progressView setProgress: self.topic.pictureProgress animated:YES ];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        if (error) {
            
            [SVProgressHUD dismissWithDelay:1.5];
            [SVProgressHUD showErrorWithStatus:@"图片加载失败"];
        }

    }];
}


//  返回
- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//  转发
- (IBAction)sharePicture:(id)sender {
}

//  保存
- (IBAction)savePicture:(id)sender {
    //  写入相册
    if (self.imageView.image) {
         UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        [SVProgressHUD dismissWithDelay:1.5];
        [SVProgressHUD showErrorWithStatus:@"图片加载中"];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    [SVProgressHUD dismissWithDelay:1.5];
    if (error) {
        [SVProgressHUD showWithStatus:@"图片保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

@end
