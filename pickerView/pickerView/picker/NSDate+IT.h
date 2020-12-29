//
//  NSDate+IT.h
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (IT)

#pragma mark - 获取日历单例对象
+ (NSCalendar *)calendar;

#pragma mark - 获取指定日期
+(NSDate *)getSomeDateWithOffset:(NSInteger)offset;

#pragma mark - 日期值
+(NSArray *)getDayArr;

#pragma mark - 小时值
+(NSArray *)getHourArr;

#pragma mark - 分钟值
+(NSArray *)getMinuteArr;

#pragma mark - 获取指定日期的年份
- (NSInteger)ex_year;

#pragma mark - 获取指定日期的月份
- (NSInteger)ex_month;

#pragma mark - 获取指定日期的天
- (NSInteger)ex_day;

#pragma mark - 获取指定日期的小时
- (NSInteger)ex_hour;

#pragma mark - 获取指定日期的分钟
- (NSInteger)ex_minute;

#pragma mark - date->yyyy年MM月dd日_week
-(NSString *)convertDateToStr;

#pragma mark - yyyy年MM月dd日HH时mm分 -> date
+(NSDate *)convertStrToDate:(NSString *)dateStr;
@end

NS_ASSUME_NONNULL_END
