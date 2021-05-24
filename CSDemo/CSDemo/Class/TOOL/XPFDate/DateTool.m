// 

#import "DateTool.h"

@implementation DateTool

+ (NSTimeInterval)pleaseInsertStarTime:(long)startTime andInsertEndTime:(long)endTime{
    NSTimeInterval balance = endTime - startTime;
    return balance;
}


+ (NSTimeInterval)pleaseInsertNowTimeAndInsertEndTime:(long)endTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    long startTime = [datenow timeIntervalSince1970];
    NSTimeInterval balance = endTime - startTime;
    return balance;
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (NSString *)time_timestampToString:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}
 
// 获取当地当前时间
+ (NSString *)getCurrentTime{
    return [self getCurrentTimeWithFormate:@"yyyy-MM-dd"];
}

+ (NSString *)getCurrentTimeWithFormate:(NSString *)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSInteger)todayTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    return  [datenow timeIntervalSince1970];
}

+(NSString *)getTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday |NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+(NSString *)getYesterDay:(NSDate *)aDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday |NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]-1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}


+ (NSDictionary *)getWeekBeginAndEnd {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1){
        firstDiff = -6;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    //在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    return @{WeekStart:firstDay,WeekEnd:lastDay};
}

+ (NSDictionary *)getWeekendBeginAndEnd{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1){//今天是周日
        firstDiff = -1;
        lastDiff = 0;
    }else{
        firstDiff = 8 - weekDay -1;
        lastDiff = 8 - weekDay;
    }
    //在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    return @{WeekStart:firstDay,WeekEnd:lastDay};
}


+ (NSDictionary *)getMonthBeginAndEnd{
    NSDate *newDate = [NSDate date];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    //设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]; //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    return @{MonthStart:beginString,MonthEnd:endString};
}


#pragma mark ------

#pragma mark - 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSDate *)currentDate {
    // 获取系统当前时间
    return [NSDate date];
}
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr currentDate:(NSDate *)currentDate
{
    // 获取系统当前时间
    //NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}
#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

#pragma mark ---- 将时间戳转换成时间
+ (NSString *)xpfTimeFromTimestamp:(NSString *)times formatter:(NSString *)formatterStr
{ //将对象类型的时间转换为NSDate类型
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:[times integerValue]];
    //设置时间格式
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

/**
 *  MyDate 当前时间
 *  year、 month、 day、 -2就是当天往前推。2就是当天以后
 **/
+ (NSString *)xpfMyDate:(NSDate *)MyDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    //得到当前的时间
    NSDate *mydate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    XPFLog(@"---当前的时间的字符串 =>  %@",currentDateStr);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
} 
/**
 *  MyDate 当前时间
 *  year、 month、 day、 -2就是当天往前推。2就是当天以后
 **/
+ (NSDate *)xpfDateMyDate:(NSDate *)MyDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    //得到当前的时间
    NSDate *mydate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    XPFLog(@"---当前的时间的字符串 =>  %@",currentDateStr);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    //NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return newdate;
}

/**
    NSCalendarUnitYear  = kCFCalendarUnitYear,
    NSCalendarUnitMonth = kCFCalendarUnitMonth,
    NSCalendarUnitDay   = kCFCalendarUnitDay,
 */
+ (NSInteger)xpfInMonthNumberOfDays:(NSCalendarUnit)calendarUnit
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:calendarUnit forDate:currentDate];
    return range.length;
}
#pragma mark -->获取今天星期几 
+ (NSString *)xpfWeekdayStringFromDate:(NSDate *)inputDate
{
    NSArray *weekday = [NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekday objectAtIndex:theComponents.weekday];
}
+ (NSString *)xpfWeekdayStringFromTime:(NSString *)timeStr
{
    //设置时间显示格式:
    //NSString *timeStr = @"2020-03-01";
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //[formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeStr];//------------将字符串按formatter转成nsdate
    NSTimeInterval endTime = [date timeIntervalSince1970] + 8*60*60;
    date = [NSDate dateWithTimeIntervalSince1970:endTime];
    
    NSArray *weekday = [NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekday objectAtIndex:theComponents.weekday];
}
//将时间戳转换成NSDate,转换的时间我也不知道是哪国时间,应该是格林尼治时间
- (NSDate *)changeSpToTime:(NSString *)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString integerValue]];
    return confromTimesp;
}
//将NSDate按 你要的 (yyyy-MM-dd) 格式时间输出
+ (NSString *)xpfDateToString:(NSDate *)date formatter:(NSString *)formatterStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:formatterStr];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}
/// 指定 某年的某月 天数 (timeStr = @"2020-03-01")
+ (NSInteger)xpfMonthLength:(NSString *)timeStr
{
    //设置时间显示格式:
    //NSString *timeStr = @"2020-03-01";
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //[formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeStr];//------------将字符串按formatter转成nsdate
    NSTimeInterval endTime = [date timeIntervalSince1970] + 8*60*60;
    date = [NSDate dateWithTimeIntervalSince1970:endTime];
    
    //NSDate *date = [NSDate date];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    // dayCountOfThisMonth就是date月份的天数
    NSInteger dayCountOfThisMonth = daysInLastMonth.length;
    return dayCountOfThisMonth;
}

/// 年 月 日 时 分 秒 (formatterStr @"YYYY-MM-dd")
+ (NSDateComponents *)xpfDateComponentsTime:(NSString *)timeStr formatter:(NSString *)formatterStr
{
    //设置时间显示格式:
    //NSString *timeStr = @"2020-03-01";
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeStr];//------------将字符串按formatter转成nsdate
    NSTimeInterval endTime = [date timeIntervalSince1970] + 8*60*60;
    date = [NSDate dateWithTimeIntervalSince1970:endTime];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];//[NSDate date]
    return comps;
}

@end
