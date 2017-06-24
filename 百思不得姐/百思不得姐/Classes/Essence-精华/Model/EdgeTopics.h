//
//  EdgeTopics.h
//  百思不得姐
//
//  Created by Edge on 2017/4/27.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 判断图片类型（SDWebImage判断方法）拿到第一个字节进行判断
 switch (c) {
 case 0xFF:
 return @"image/jpeg";
 case 0x89:
 return @"image/png";
 case 0x47:
 return @"image/gif";
 case 0x49:
 case 0x4D:
 return @"image/tiff";
 case 0x52:
 // R as RIFF for WEBP
 if ([data length] < 12) {
 return nil;
 }

 */
@interface EdgeTopics : NSObject
    //名称
@property(copy,nonatomic)NSString *name;
    // 头像
@property(copy,nonatomic)NSString *profile_image;
    //  时间
@property(copy,nonatomic)NSString *create_time;
    //  文字
@property(copy,nonatomic)NSString *text;
    // 顶
@property(assign,nonatomic)NSInteger ding;
    // 踩
@property(assign,nonatomic)NSInteger cai;
    // 转发
@property(assign,nonatomic)NSInteger repost;
    // 评论
@property(assign,nonatomic)NSInteger comment;
//  是否为会员
@property(assign,nonatomic,getter=isSina_V)BOOL sina_v;

/*==========图片========================*/
// 图片url
@property(copy,nonatomic)NSString *imageurl;
//  图片高度
@property(assign,nonatomic)CGFloat height;
//  图片宽度
@property(assign,nonatomic)CGFloat width;

//  动态图
@property(assign,nonatomic,getter=isGif)BOOL gif;

/*==========声音========================*/
//  声音时长(s)
@property(assign,nonatomic)NSInteger voicetime;
//  声音地址
@property(copy,nonatomic)NSString *videouri;
//播放次数
@property(assign,nonatomic)NSInteger playcount;

/*==========视频========================*/
//  视频图片地址
@property(copy,nonatomic)NSString *cdn_img ;
//  视频时长(s)
@property(assign,nonatomic)NSInteger videotime;
//  视频地址
@property(copy,nonatomic)NSString *voiceuri;
//播放次数
//@property(assign,nonatomic)NSInteger playcount;
/*=================辅助属性=====================*/
//  帖子参数
@property(assign,nonatomic)EdgeTopicType type;
//  大图
@property(assign,nonatomic,getter=isBigPicture)BOOL BigPicture;

//  cell的高度
@property(assign,nonatomic,readonly)CGFloat cellHeight;
//  图片控件fream
@property(assign,nonatomic,readonly)CGRect pictureViewFream;
//  图片下载进度
@property(assign,nonatomic)CGFloat pictureProgress;
//  声音控件fream
@property(assign,nonatomic,readonly)CGRect voiceViewFream;
//  视频控件fream
@property(assign,nonatomic,readonly)CGRect VedioViewFream;
/** 图片下载完毕 */
@property(assign,nonatomic,getter=isLoadImageFinish)BOOL loadImageFinish;

@end
