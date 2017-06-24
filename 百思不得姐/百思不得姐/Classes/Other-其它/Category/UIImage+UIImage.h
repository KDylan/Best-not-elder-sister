//
//  UIImage+UIImage.h
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage)
/** 保持不渲染的图片  */
@property(nonatomic,strong,readonly)UIImage * originarImage;
/** 可拉伸的图片  */
@property(nonatomic,strong,readonly)UIImage * resizbleImage;
// 保持图片不渲染
+(UIImage *)imageOriginalImaged:(NSString *)imageName;
//  保证屏幕四周不虚化
+(UIImage *)resiziable:(NSString *)name;
@end
