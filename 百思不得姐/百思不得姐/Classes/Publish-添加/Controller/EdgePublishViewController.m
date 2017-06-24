//
//  EdgePublishViewController.m
//  百思不得姐
//
//  Created by Edge on 2017/5/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgePublishViewController.h"
#import "EdgePublishButton.h"
#import <POP.h>//  动画

@interface EdgePublishViewController ()
@property(strong,nonatomic)NSArray *arr;
@property(weak,nonatomic)UIImageView *slogonView;

@end

@implementation EdgePublishViewController
-(NSArray *)arr{
    if (!_arr) {
        self.arr = @[
                     @{@"icon":@"publish-video",@"name":@"发视频"},
                     @{@"icon":@"publish-picture",@"name":@"发图片"},
                     @{@"icon":@"publish-text",@"name":@"发段子"},
                     @{@"icon":@"publish-audio",@"name":@"发声音"},
                     @{@"icon":@"publish-review",@"name":@"审帖"},
                     @{@"icon":@"publish-offline",@"name":@"离线下载"}
                     ];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPublishButton];
    [self addSloaganImage];

}
//  添加标语
-(void)addSloaganImage{
    
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
   
    self.slogonView = slogan;
    
    [self.view addSubview:slogan];
   
    CGFloat centerEndX = ScreenWidth/2;
    CGFloat centerEndy = ScreenHeigth*0.2;
    CGFloat centerBeginY = -slogan.height/2;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springSpeed = 20;
    anim.springBounciness = 15;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerEndX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerEndX, centerEndy)];

    //  开始时间
    anim.beginTime = CACurrentMediaTime() + self.arr.count * 0.1;
    [slogan pop_addAnimation:anim forKey:nil];
    
    [anim setCompletionBlock:^(POPAnimation *anima ,BOOL finish){
        //  结束后开启交互
        self.view.userInteractionEnabled = YES;
    }];
}
//  添加6个发布按钮
-(void)addPublishButton{
    //  关闭交互
    self.view.userInteractionEnabled = NO;
    
    //  设置数据
//    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
//    
//    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //  按钮尺寸
    CGFloat btnW = 72;
    CGFloat btnH = btnW +30;
    CGFloat startX = 25;
    CGFloat startY = (ScreenHeigth - 2*btnH)/2;
    // 列
    int maxCols = 3;
    //  每列的间距
    CGFloat btnMargin = (ScreenWidth-2*startX-maxCols*btnW)/(maxCols-1);
    
    for (int i=0; i<self.arr.count; i++) {
        
         EdgePublishButton *publishBtn = [[EdgePublishButton alloc]init];
        NSDictionary *dic = self.arr[i];
        publishBtn.tag = i;
        [publishBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:dic[@"icon"]] forState:(UIControlStateNormal)];
        [publishBtn addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
        //  第几列
        int col = i % maxCols;
        //  第几行
        int row = i / maxCols;
        //  实际X
        CGFloat X = startX + (btnW + btnMargin) * col;
        //  实际Y
        CGFloat Y = startY + row * btnH;
        
      //  publishBtn.frame = CGRectMake(X, Y, btnW, btnH);
        
        [self.view addSubview:publishBtn];
        
        //  添加动画
        
        CGFloat AnimationY = -btnH;
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];//  改变动画
        
        springAnimation.springSpeed = 20;
        springAnimation.springBounciness = 15;
        
        springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(X, AnimationY, btnW, btnH)];
        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(X, Y, btnW, btnH)];
     //  延时开始时间
        springAnimation.beginTime = CACurrentMediaTime() + i * 0.1;
        
        [publishBtn pop_addAnimation:springAnimation forKey:nil];
        
    }
}
//  按钮点击
-(void)clickButton:(UIButton *)btn{
    //  点击按钮关闭
    [self cancleIsFinishBlock:^{
          NSLog(@"的段子");
    }];
  
}

-(void)cancleIsFinishBlock:(void(^)())finishBlock{
    //  动画完成才可以点击
    self.view.userInteractionEnabled = NO;
    //  一个一个往下掉(拿到子空间设置)
    for (int i=2; i<self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        //  动画
        POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, ScreenHeigth+subView.height)];
        anima.beginTime = CACurrentMediaTime() +(i-2)*0.1;
        
        [subView pop_addAnimation:anima forKey:nil];
        
        //  所有动画完成后销毁控制器
        if (i==self.view.subviews.count-1) {
            
            //  干掉发布界面再执行block
            [anima setCompletionBlock:^(POPAnimation *anima,BOOL finish){
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                //  执行动画
                if (finishBlock) {//  如果不为空执行block
                    
                    finishBlock();
                    
                }
                
            }];
        }
    }

}
//  取消按钮
- (IBAction)cancleButton:(id)sender {
    
    [self cancleIsFinishBlock:nil];
    
   }

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [self cancleIsFinishBlock:nil];
}

@end
