//
//  NSDate+IT.m
//  InduceTool
//
//  Created by 魏延龙 on 2020/12/11.
//  Copyright © 2020 魏延龙. All rights reserved.
//

#import "NSDate+IT.h"
static const NSCalendarUnit unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (IT)

#pragma mark - 获取日历单例对象
+ (NSCalendar *)calendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        // 创建日历对象，指定日历的算法（公历）
        sharedCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return sharedCalendar;
}

#pragma mark - 日期值
+(NSArray *)getDayArr {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<1000; i++) {
        NSDate *date = [NSDate getSomeDateWithOffset:-i];
        NSString *result = [date convertDateToStr];
        [tempArray addObject:result];
    }
    
    for (int i = 1; i<1000; i++) {
        NSDate *date = [NSDate getSomeDateWithOffset:+i];
        NSString *result = [date convertDateToStr];
        [tempArray insertObject:result atIndex:0];
    }
    return [[tempArray reverseObjectEnumerator] allObjects];
}
#pragma mark - 小时值
+(NSArray *)getHourArr {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 24; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02d时",i];
        [tempArray addObject:str];
    }
    return [tempArray copy];
}

#pragma mark - 分钟值
+(NSArray *)getMinuteArr {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 60; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02d分",i];
        [tempArray addObject:str];
    }
    return [tempArray copy];
}
#pragma mark - 获取指定日期
+(NSDate *)getSomeDateWithOffset:(NSInteger)offset {
    NSDate *date = [NSDate date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:offset];
    NSDate *newdate = [[NSDate calendar] dateByAddingComponents:adcomps toDate:date options:0];
    return newdate;
}
#pragma mark - 获取指定日期的星期
- (NSInteger)ex_weekday {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.weekday;
}

#pragma mark - 获取指定日期的星期
- (NSString *)ex_weekdayString {
    switch (self.ex_weekday - 1) {
        case 0:
        {
            return @"周日";
        }
            break;
        case 1:
        {
            return @"周一";
        }
            break;
        case 2:
        {
            return @"周二";
        }
            break;
        case 3:
        {
            return @"周三";
        }
            break;
        case 4:
        {
            return @"周四";
        }
            break;
        case 5:
        {
            return @"周五";
        }
            break;
        case 6:
        {
            return @"周六";
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}
#pragma mark - 获取指定日期的年份
- (NSInteger)ex_year {
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.year;
}

#pragma mark - 获取指定日期的月份
- (NSInteger)ex_month {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.month;
}

#pragma mark - 获取指定日期的天
- (NSInteger)ex_day {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.day;
}

#pragma mark - 获取指定日期的小时
- (NSInteger)ex_hour {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.hour;
}

#pragma mark - 获取指定日期的分钟
- (NSInteger)ex_minute {
    NSDateComponents *comps = [[NSDate calendar] components:unitFlags fromDate:self];
    return comps.minute;
}

#pragma mark - date->yyyy年MM月dd日_week
-(NSString *)convertDateToStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSString *weekStr = [self ex_weekdayString];
    NSString *result = [NSString stringWithFormat:@"%@_%@",dateStr,weekStr];
    return result;
}

#pragma mark - yyyy年MM月dd日HH时mm分 -> date
+(NSDate *)convertStrToDate:(NSString *)dateStr {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    NSDate *date =[dateFormat dateFromString:dateStr];
    return date;
}
@end
