//
//  NSDate+EdgeExtention.h
//  百思不得姐
//
//  Created by Edge on 2017/5/3.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EdgeExtention)

//求出时间差
-(NSDateComponents *)dateFrom:(NSDate *)from;
//  是否是今年
-(BOOL)isThisYear;
//  是否是今天
-(BOOL)isToday;
//  是否是昨天
-(BOOL)isYesterday;

@end
