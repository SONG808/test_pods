//
//  LSCalculateTime.m
//  test
//
//  Created by 木木木公 on 2017/4/1.
//  Copyright © 2017年 木木木公. All rights reserved.
//

#import "LSCalculateTime.h"

@interface LSCalculateTime ()

@property(nonatomic, strong) NSCalendar      * calender;
@property(nonatomic, strong) NSDateFormatter * formatter;

@end

@implementation LSCalculateTime

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

/**
 数据初始化
 */
- (void)defaultSetting {
    
    //默认日历格式为 时 分 秒
    self.unit = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    //默认开始/结束 date
    self.endDate   = [self localDate];
    
    
}

#pragma mark - 自定义方法

#pragma makr 公共方法
- (NSDateComponents *)getDiffCommponents
{
    if ([self diffTimeIntervalFromDate:[self localDate] toDate:self.endDate] <=0 ) {
        NSDateComponents * date = [[NSDateComponents alloc]init];
        date.hour = 0;
        date.second = 0;
        date.minute = 0;
        return date;
    }
   return  [self diffComponentsFromDate:[self localDate] toDate:self.endDate];
}

- (NSTimeInterval)getDiffTimeInterval
{
    return [self diffTimeIntervalFromDate:[self localDate] toDate:self.endDate];
}
#pragma mark 内部方法
/**
 格式化字符串时间

 @param time 需要格式化的字符串
 @return     格式化后的时间
 */
- (NSDate *)getDateFromString:(NSString *)time {
    
    return [self.formatter dateFromString:time];
}


/**
 计算本地时区时间
 */
- (NSDate *)localDate {
    //计算本地时间
    NSDate * cuurentDate = [NSDate date];
    
    //计算时区差值
    NSTimeInterval time  = [[NSTimeZone localTimeZone] secondsFromGMTForDate:cuurentDate];
    
    //计算本地实际时间
    cuurentDate          = [cuurentDate dateByAddingTimeInterval:time];
    
    return cuurentDate;
}


/**
 计算时间差值

 @param fromDate 开始时间
 @param toDate   结束时间
 @return         时间差值（NSDateComponents）
 */
- (NSDateComponents *)diffComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    return [self.calender components:self.unit fromDate:fromDate toDate:toDate options:0];
}


/**
 计算时间差值

 @param fromDate 开始时间
 @param toDate   结束时间
 @return         时间差值（秒）
 */
- (NSTimeInterval)diffTimeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    return [toDate timeIntervalSinceDate:fromDate];
}

#pragma mark - setter/getter

- (NSDateFormatter *)formatter {
    
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
        _formatter.dateFormat = self.timeFormatter;
        _formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return _formatter;
}

- (NSCalendar *)calender {
    
    if (!_calender) {
        _calender = [NSCalendar currentCalendar];
    }
    return _calender;
}

- (NSDate *)endDate {
    
    if (!_endDate) {
        _endDate = [self localDate];
    }
    return _endDate;
}

- (void)setEndTime:(NSString *)endTime
{
    if (!endTime || endTime.length == 0) return;
    
    _endTime = endTime;
    
    self.endDate = [self getDateFromString:self.endTime];
}

- (NSString *)timeFormatter{
    
    if (!_timeFormatter) {
        _timeFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    return _timeFormatter;
}


@end
