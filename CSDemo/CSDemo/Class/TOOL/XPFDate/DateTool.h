// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define WeekStart @"weekStart"
#define WeekEnd   @"WeekEnd"

#define MonthStart @"MonthStart"
#define MonthEnd   @"MonthEnd"


@interface DateTool : NSObject
//计算两个时间差
+ (NSTimeInterval)pleaseInsertStarTime:(long)startTime andInsertEndTime:(long)endTime;
+ (NSTimeInterval)pleaseInsertNowTimeAndInsertEndTime:(long)endTime;

//计算时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//时间戳转时间字符串
+ (NSString *)time_timestampToString:(NSInteger)timestamp andFormatter:(NSString *)format;

+ (NSInteger)todayTimestamp;

+ (NSString *)getCurrentTime;
+ (NSString *)getCurrentTimeWithFormate:(NSString *)formate;

+(NSString *)getTomorrowDay:(NSDate *)aDate;
+(NSString *)getYesterDay:(NSDate *)aDate;

+ (NSDictionary *)getWeekBeginAndEnd;
+ (NSDictionary *)getWeekendBeginAndEnd;
+ (NSDictionary *)getMonthBeginAndEnd;

#pragma mark - 获取当前的时间
+ (NSDate *)currentDate;
+ (NSString *)currentDateString;
#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr;
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr currentDate:(NSDate *)currentDate;

#pragma mark ---- 将时间戳转换成时间
+ (NSString *)xpfTimeFromTimestamp:(NSString *)times formatter:(NSString *)formatterStr;
/**
 *  MyDate 当前时间
 *  year、 month、 day、 -2就是当天往前推。2就是当天以后
 **/
+ (NSString *)xpfMyDate:(NSDate *)MyDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/**
 *  MyDate 当前时间
 *  year、 month、 day、 -2就是当天往前推。2就是当天以后
 **/
+ (NSDate *)xpfDateMyDate:(NSDate *)MyDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
    NSCalendarUnitYear  = kCFCalendarUnitYear,
    NSCalendarUnitMonth = kCFCalendarUnitMonth,
    NSCalendarUnitDay   = kCFCalendarUnitDay,
 */
+ (NSInteger)xpfInMonthNumberOfDays:(NSCalendarUnit)calendarUnit;
///
+ (NSString *)xpfWeekdayStringFromDate:(NSDate *)inputDate;
+ (NSString *)xpfWeekdayStringFromTime:(NSString *)timeStr;

//将NSDate按 你要的 (yyyy-MM-dd) 格式时间输出
+ (NSString *)xpfDateToString:(NSDate *)date formatter:(NSString *)formatterStr;
/// 指定 某年的某月 天数 (timeStr = @"2020-03-01")
+ (NSInteger)xpfMonthLength:(NSString *)timeStr;
/// 年 月 日 时 分 秒 (formatterStr @"YYYY-MM-dd")
+ (NSDateComponents *)xpfDateComponentsTime:(NSString *)timeStr formatter:(NSString *)formatterStr;

@end

NS_ASSUME_NONNULL_END
