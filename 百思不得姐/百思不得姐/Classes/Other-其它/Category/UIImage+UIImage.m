//
//  UIImage+UIImage.m
//  百思不得姐
//
//  Created by Edge on 17/4/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UIImage+UIImage.h"

@implementation UIImage (UIImage)
-(UIImage *)originarImage{
    
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(UIImage *)resizbleImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.width * 0.5];
}
+(UIImage *)imageOriginalImaged:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
+(UIImage *)resiziable:(NSString *)name{
    UIImage *image = [UIImage imageOriginalImaged:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.width * 0.5];
    return  image;
}
@end
