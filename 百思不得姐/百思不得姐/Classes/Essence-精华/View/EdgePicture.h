//
//  EdgePicture.h
//  百思不得姐
//
//  Created by Edge on 2017/5/4.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdgeTopics.h"
@interface EdgePicture : UIView

+(instancetype)loadPictureXib;
//  模型数据
@property(strong,nonatomic)EdgeTopics *topic;
@end
