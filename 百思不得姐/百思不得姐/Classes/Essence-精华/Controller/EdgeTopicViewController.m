
//
//  EdgeTopicViewController.m
//  百思不得姐
//
//  Created by Edge on 2017/4/22.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "EdgeTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>// 字典转模型
#import "EdgeTopics.h"
#import <MJRefresh.h>
#import "EdgeTopicsCell.h"
@interface EdgeTopicViewController ()
//帖子数据
@property(nonatomic ,strong)NSMutableArray *topics;
// 加载下一页数据
@property(copy,nonatomic)NSString *maxtime;
//页数
@property(assign,nonatomic)NSInteger page;

// 请求参数
@property(nonatomic,strong)NSDictionary *params;//  防止用户上拉又下拉造成数据错误
@end

@implementation EdgeTopicViewController
static NSString * const TopicCellID = @"TopicCell";

-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.view.backgroundColor = [UIColor redColor];
    // 下拉刷新
    [self setupRefresh];
    // 初始化tableview
    [self setupTableview];
}

// 初始化tableview
-(void)setupTableview{
    //  处理分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//  没有分割线
    //  背景透明
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EdgeTopicsCell class]) bundle:nil] forCellReuseIdentifier:TopicCellID];
}

// 下拉刷新
-(void)setupRefresh{
    
    // 头部下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsTopics)];
    // 一进来就开始刷新
    [self.tableView.mj_header beginRefreshing];
    //  根据位置隐藏
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //  上拉加载更多
    self.tableView.mj_footer  = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
//  上拉加载更多
-(void)loadMoreTopics{
    //  进来就结束下拉加载更多
    [self.tableView.mj_header endRefreshing];
    
    // url
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php";
    // NSURL *url = [NSURL URLWithString:urlStr];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    params[@"page"]=@(self.page);
    params[@"maxtime"]=self.maxtime;
    
    self.params = params;
    
    //  加载数据
    [[AFHTTPSessionManager manager]GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if(self.params !=params )
        {
            return ;// 如果两次请求参数不同，那么说明发送新的请求
        }
        
        //存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //    NSLog(@"%@===",self.maxtime);
        //  加载完成页码增加
        self.page++;
        
        //成功了后拼接数据
        NSArray *arr = [EdgeTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:arr];
        // 刷新页面
        [self.tableView reloadData];
        
        //  上拉结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //  上拉结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
//加载新的帖子数据
-(void)loadNewsTopics{
    //  进来就结束上拉加载更多
    [self.tableView.mj_footer endRefreshing];
    // url
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php";
    // NSURL *url = [NSURL URLWithString:urlStr];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    self.params = params;
    //  加载数据
    [[AFHTTPSessionManager manager]GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if(self.params !=params )
        {
            return ;// 如果两次请求参数不同，那么说明发送新的请求
        }
        // 页码清零
        self.page=0;
        //    self.topics = responseObject[@"list"];
        self.topics = [EdgeTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // NSLog(@"%@",self.maxtime);
        //  结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        //        // 数据保存为infoplist
        //[responseObject writeToFile:@"/Users/edge/Desktop/百思不得姐/百思不得姐/Data.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //  结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EdgeTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    //  set方法
    cell.topics = self.topics[indexPath.row];
    //    // 赋值数据
    //    EdgeTopics *topics = self.topics[indexPath.row];
    //    cell.textLabel.text = topics.name;
    //    NSURL *picURL = [NSURL URLWithString:topics.profile_image];;
    //   // [cell.imageView sd_setImageWithURL:picURL];
    //    //  解决下载图片后UI不刷新问题
    //    [cell.imageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EdgeTopics *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

@end
