//
//  LSCalculateTime.h
//  test
//
//  Created by 木木木公 on 2017/4/1.
//  Copyright © 2017年 木木木公. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCalculateTime : NSObject


/**
 结束时间
 */
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSDate   * endDate;

/**
 时间格式
 */
@property(nonatomic, strong) NSString * timeFormatter;


/**
 日历类型
 */
@property(nonatomic, assign) NSCalendarUnit  unit;

- (NSDate *)getDateFromString:(NSString *)time;

- (NSDateComponents *)getDiffCommponents;

- (NSTimeInterval)getDiffTimeInterval;

@end
