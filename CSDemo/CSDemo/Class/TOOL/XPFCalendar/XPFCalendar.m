// 

#import "XPFCalendar.h"
/// 前几个月 10月 9 8 7
static const NSInteger FrontMonth = 3;

@interface XPFCalendar ()

@end

@implementation XPFCalendar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addCalendarUI];
    }
    return self;
}

- (void)addCalendarUI
{
    
}

- (void)onceshi
{
    //设置时间显示格式:
    NSString *timeStr = @"2020-03-01";
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //[formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeStr];//------------将字符串按formatter转成nsdate
    NSTimeInterval endTime = [date timeIntervalSince1970] + 8*60*60;
    date = [NSDate dateWithTimeIntervalSince1970:endTime];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];//[NSDate date]
    
    //NSDateComponents *comps = [DateTool xpfDateComponentsTime:@"2020-03-01" formatter:@"YYYY-MM-dd"];
    
    NSString *yearStr = @"";
    NSString *monthStr = @"";
    NSString *rqStr = @"";
    
    for (int i = 1; i < 3+1; i++)
    {
        if ((comps.month - 1) - i >= 0)
        { // 当年
            yearStr = [NSString stringWithFormat:@"%ld", comps.year];
            monthStr = [NSString stringWithFormat:@"%ld", comps.month - i];
        }
        if ((comps.month - 1) - i < 0)
        { // 上一年
            if ((comps.month - 1) - i == -3)
            {
                yearStr = [NSString stringWithFormat:@"%ld", comps.year - 1];
                monthStr = [NSString stringWithFormat:@"%d", 12 - 2];
            }
            else if ((comps.month - 1) - i == -2)
            {
                yearStr = [NSString stringWithFormat:@"%ld", comps.year - 1];
                monthStr = [NSString stringWithFormat:@"%d", 12 - 1];
            }
            else if ((comps.month - 1) - i == -1)
            {
                yearStr = [NSString stringWithFormat:@"%ld", comps.year - 1];
                monthStr = [NSString stringWithFormat:@"%d", 12 - 0];
            }
        }
        if (monthStr.length == 1)
        {
            monthStr = [NSString stringWithFormat:@"0%@", monthStr];
        }
        rqStr = [NSString stringWithFormat:@"%@-%@-01", yearStr, monthStr];
        XPFLog(@" 输出的日期: %@, 当月天数: %ld, 星期: %@", rqStr, (long)[DateTool xpfMonthLength:rqStr], [DateTool xpfWeekdayStringFromTime:rqStr]);
    }
    
    XPFLog(@"= 输入日期date => %@, 日期: %@, 星期: %@, 前面推3月月份: %@, (%ld, %ld, %ld), date -> str: %@", date, [DateTool currentDateStringWithFormat:@"YYYY-MM-dd" currentDate:date], [DateTool xpfWeekdayStringFromDate:date], rqStr, comps.month, comps.day, (comps.month - 1) - 3, [DateTool xpfDateToString:date formatter:@"YYYY-MM-dd"]);
    
}

@end
