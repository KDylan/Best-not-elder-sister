//
//  EdgeEssenceViewController.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeEssenceViewController.h"
#import "EdgeTopicViewController.h"
//#import "EdgeAllTableViewController.h"
//#import "EdgePictureTableViewController.h"
//#import "EdgeWordTableViewController.h"
//#import "EdgeVideoTableViewController.h"
//#import "EdgeVoiceTableViewController.h"
@interface EdgeEssenceViewController ()<UIScrollViewDelegate>
// 指示器
@property(nonatomic,weak)UIView *directorView;
//  选中按钮
@property(nonatomic,weak)UIButton *selectBtn;
// titleView
@property(nonatomic,weak)UIView *titleView;
//  内容view
@property(nonatomic,weak)UIScrollView *contentView;
@end

@implementation EdgeEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= EdgeGloupColor;

  //  设置导航栏图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
/*不能完成点击切换图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:@"MainTagSubIcon" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    */
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem iteamWithImageNamed:@"MainTagSubIcon" hightLightImageName:@"MainTagSubIconClick" target:self action:@selector(click)];
  
    //  初始化子控制器
    [self setupChildVc];
    // 初始化标题栏
    [self setupTitleView];
   
    //  初始化ScrollView
    [self addScrollView];
}

-(void)setupChildVc{
    
    EdgeTopicViewController *pictureVC = [[EdgeTopicViewController alloc]init];
    pictureVC.title = @"图片";
    pictureVC.type = EdgeTopicPicture;
    [self addChildViewController:pictureVC];
    
    EdgeTopicViewController *allVC = [[EdgeTopicViewController alloc]init];
    allVC.title = @"全部";
    allVC.type = EdgeTopicAll;
    [self addChildViewController:allVC];
    
    EdgeTopicViewController *voiceVC = [[EdgeTopicViewController alloc]init];
    voiceVC.title = @"声音";
    voiceVC.type = EdgeTopicVoice;
    [self addChildViewController:voiceVC];
    
    EdgeTopicViewController *vedioVC = [[EdgeTopicViewController alloc]init];
    vedioVC.title = @"视频";
    vedioVC.type= EdgeTopicVedio;
    [self addChildViewController:vedioVC];
    
       EdgeTopicViewController *wordVC = [[EdgeTopicViewController alloc]init];
    wordVC.title = @"段子";
    wordVC.type = EdgeTopicWord;
    [self addChildViewController:wordVC];
}
//  设置顶部标题栏
-(void)setupTitleView{
    
    //  设置标题
    UIView *titleView = [[UIView alloc]init];
    titleView.wdith = self.view.wdith;
    titleView.height = 35;
    titleView.y = 64;
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    self.titleView = titleView;
    
    [self.view addSubview:titleView];
    //  添加指示器
    UIView *indictorView = [[UIView alloc]init];
    indictorView.backgroundColor = [UIColor redColor];
    indictorView.height = 2;
    indictorView.y = titleView.height-indictorView.height;
    self.directorView = indictorView;
    
    
    //  添加子标题
    NSArray *childs = self.childViewControllers;
    
   // NSArray *title = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat btn_Width = self.view.wdith/childs.count;
    CGFloat btn_Heigth = titleView.height;
    for (int i=0; i<childs.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        //  创建按钮
        btn.tag = i;
        btn.wdith = btn_Width;
        btn.height = btn_Heigth;
        btn.x = btn_Width * i;
         UIViewController *vc = childs[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //  文字改变颜色
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        [btn addTarget:self action:@selector(titleSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        //  进来后显示第一个指数器
        if (i==0) {
            btn.enabled = NO;
            self.selectBtn = btn;
            //  设置指示器
            [btn layoutIfNeeded];
            self.directorView.wdith = btn.titleLabel.wdith;
            self.directorView.centerX = btn.centerX;
        }
        [titleView addSubview:btn];
    }
    //  添加指示器
    [titleView addSubview:indictorView];
}
//  选中标题
-(void)titleSelected:(UIButton *)btn{
    
    [UIView animateWithDuration:0.25 animations:^{
        //  移动指示器
        self.directorView.wdith = btn.titleLabel.wdith;
        self.directorView.centerX = btn.centerX;
    }];
    //选中后变色
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    
    //  滚动contentView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag *self.contentView.wdith;
    [self.contentView setContentOffset:offset animated:YES];
    
}
// 添加scrollView
-(void)addScrollView{
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.delegate = self;
    self.contentView = contentView;
    contentView.frame = [UIScreen mainScreen].bounds;
    contentView.pagingEnabled = YES;//  分页
    //  系统不自动设置页边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //  设置滚动区域
    contentView.contentSize = CGSizeMake(self.childViewControllers.count*contentView.wdith, 0);
    //  设置最底层
    [self.view insertSubview:contentView atIndex:0];
    
    //  运行加载第一个控制器（手动调用）
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
}
#pragma mark UIScrollview代理
//  滚动完毕调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //  要知道加载哪个控制器
    //  根据偏移量获取索引（偏移量除以宽度就可以获取偏移脚标）
    NSInteger index = scrollView.contentOffset.x/scrollView.wdith;
    //  取出当前控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.tableView.height = scrollView.height;
    
//    NSLog(@"vc.tableView.height=%f",vc.tableView.height);
//    NSLog(@"scrollView.height=%f",self.view.height);
    
    vc.view.y = 0;
    //  加载控制器的view
    vc.tableView.x = scrollView.contentOffset.x;
    //  添加
    [scrollView addSubview:vc.tableView];
    
    CGFloat y = CGRectGetMaxY(self.titleView.frame);
    
    vc.tableView.contentInset = UIEdgeInsetsMake(y, 0, 49, 0);
    
    vc.tableView.contentOffset = CGPointMake(0, -y);
    
    //  滚动条内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;//  滚动条上下拉不被挡住
}
//  停止拖拽
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //  相当于点击titleiew 的方法
    NSInteger index = scrollView.contentOffset.x/scrollView.wdith;
    
    UIButton *btn = self.titleView.subviews[index];// 取出每个指示器
    
    [self titleSelected:btn];
    
    //  滚动完毕主动调用代理方法
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

-(void)click{
    NSLog(@"click");
}
@end
