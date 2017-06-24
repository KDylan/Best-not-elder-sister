//
//  NSDate+EdgeExtention.m
//  百思不得姐
//
//  Created by Edge on 2017/5/3.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "NSDate+EdgeExtention.h"

@implementation NSDate (EdgeExtention)
-(NSDateComponents *)dateFrom:(NSDate *)from{
//  拿到日历
    NSCalendar *calend = [NSCalendar currentCalendar];
    //  比较时间
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    return [calend components:unit fromDate:from toDate:self options:kNilOptions];
}

-(BOOL)isThisYear{
    // 日历
    NSCalendar *calender =[NSCalendar currentCalendar];
    
    NSInteger nowYear = [calender component:NSCalendarUnitYear fromDate:[NSDate date]];
    
     NSInteger selfYear = [calender component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

-(BOOL)isToday{
    // 日历
    NSCalendar *calender =[NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
   NSDateComponents *nowCmps = [calender components:unit fromDate:[NSDate date]];
     NSDateComponents *selfCmps = [calender components:unit fromDate:self];
    
    return nowCmps.year== selfCmps.year&&nowCmps.month==selfCmps.month&&nowCmps.day==selfCmps.day;
}

-(BOOL)isYesterday{
    //  日期格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //  清空时间保留日期
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfStr];
    
    //  日历类
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 通过日历比较日期
    NSDateComponents *cmps = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year==0&&cmps.month==0&&cmps.day==1;
}
@end
