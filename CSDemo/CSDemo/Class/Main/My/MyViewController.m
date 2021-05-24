// 

#import "MyViewController.h"

//#import "MyPagingZoonVC.h"
#import "MyOneVC.h"
#import "MyHSVC.h"


#import "XPFCommentPopupView.h"
#import "XPFSlidePopupView.h"

#import "PlaceholderTextField.h"


//#import "XPFAddImage.h"
//@class XPFAddImage;

@interface MyViewController ()
<
//UITableViewDelegate,
//UITableViewDataSource
UIDocumentInteractionControllerDelegate
>

//@property (nonatomic, strong) XPFAddImage *addimg;

//@property (nonatomic, strong) UITableView *tableView;

/// 调用safari分享功能将文件分享出去
@property (nonatomic, strong) UIDocumentInteractionController *documentIc;

/// 输入框
@property (nonatomic, strong) UITextField *textField;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    //[self onAddimgUI];
    
//    [self on_addBtn];
    
//    [self ssssss];
    
    
    NSString *str = @"0.33";
    XPFLog(@" %.2f, %.f", str.doubleValue, str.doubleValue * 100);
    
    
    
//    [self tef];
}


- (void)tef
{
 
        self.textField = [[UITextField alloc] init];
    [self.view addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.bottom.mas_equalTo(-20.5*RATIO);
            make.top.mas_equalTo(100);
            make.left.mas_equalTo(16*RATIO);
        }];
        // 设置左边视图(注意：需要先设置左边视图的显示模式为UITextFieldViewModeAlways)
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgview.image = YGIMGName(@"lufei");
        [leftView addSubview:imgview];
        self.textField.leftView = leftView;
//        self.textField.placeholder = @"请输入金额";
//        NSString *strPlace = @"请输入金额";
        //self.textField.attributedPlaceholder = [self getAttributeStringWithColor:YGAEAEAE fontSize:18 str:strPlace];
        //self.textField.placeholderColor = YGAEAEAE;
//        self.textField.placeholderFont = [UIFont systemFontOfSize:18];
        self.textField.textColor = [UIColor blueColor];
        self.textField.font = [UIFont systemFontOfSize:40];
        self.textField.adjustsFontSizeToFitWidth = YES;
        self.textField.delegate = self;
        self.textField.backgroundColor = [UIColor clearColor];


    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入占位文字" attributes: @{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:18]}];

    self.textField.attributedPlaceholder = attrString;



}


- (void)ssssss
{
    
       NSString *kongge = @"                  ";
       NSString *wenzis = @"这个是我的天使";
       
       XPFLog(@"===2112==> %@, %@", kongge, wenzis);
       if ([self isEmpty:kongge])
       {
           XPFLog(@" kongge 1111111111111 ");
       }
       else
       {
           XPFLog(@" kongge 2222222222222 ");
       }
       if ([self isEmpty:wenzis])
       {
           XPFLog(@" wenzis 1111111111111 ");
       }
       else
       {
           XPFLog(@" wenzis 2222222222222 ");
       }
       
}

//判断内容是否全部为空格 yes 全部为空格 no 不是
- (BOOL)isEmpty:(NSString *)str
{
    if (!str)
    {
        return true;
    }
    else
    {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and next line characters (U+000A–U+000D,U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self onceshi];
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

/*
- (void)onAddimgUI
{
    [self.view addSubview:self.addimg];
    [self.addimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(400);
    }];
}


- (XPFAddImage *)addimg
{
    if (!_addimg) {
        _addimg = [[XPFAddImage alloc] init];
        _addimg.backgroundColor = [UIColor grayColor];
    }
    return _addimg;
}
*/

//- (UITableView *)tableView
//{
//    if (!_tableView)
//    {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.backgroundColor = [UIColor grayColor];
//        _tableView.separatorStyle = NO;
//        [self.view addSubview:_tableView];
//
//        //[_tableView registerClass:[YGPayCell class] forCellReuseIdentifier:@"YGPayCell"];
//    }
//    return _tableView;
//}

/**
 *
 */
- (void)on_addBtn {
    
    UIButton *buttonCS1212 = [[UIButton alloc] init];
    [buttonCS1212 setTitle:@"测试" forState:(UIControlStateNormal)];
    [buttonCS1212 setBackgroundColor:[UIColor redColor]];
    [buttonCS1212 addTarget:self action:@selector(on_12312312312) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS1212];
    [buttonCS1212 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(30);
        make.width.height.mas_equalTo(80);
    }];
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"表格" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(createXLSFile) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(80);
    }];
    
    
    UIButton *hsBtn = [[UIButton alloc] init];
    [hsBtn setTitle:@"横竖" forState:(UIControlStateNormal)];
    [hsBtn setBackgroundColor:[UIColor redColor]];
    [hsBtn addTarget:self action:@selector(ActionHSBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:hsBtn];
    [hsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(80);
    }];
    
    UIButton *PLBtn = [[UIButton alloc] init];
    [PLBtn setTitle:@"评论弹窗" forState:(UIControlStateNormal)];
    [PLBtn setBackgroundColor:[UIColor redColor]];
    [PLBtn addTarget:self action:@selector(ActionPLClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:PLBtn];
    [PLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(80);
    }];
    
}

- (void)ActionPLClick
{
    XPFCommentPopupView *commentView = [XPFCommentPopupView new];
    commentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400.0f);
    
    XPFSlidePopupView *popupView = [XPFSlidePopupView popupViewWithFrame:[UIScreen mainScreen].bounds contentView:commentView];
    [popupView showFrom:[UIApplication sharedApplication].keyWindow completion:^{
        [commentView requestData];
    }];
    
}

- (void)ActionHSBtnClick
{
    MyHSVC *hsvc = [[MyHSVC alloc] init];
    [self pushViewController:hsvc];
}

- (void)on_12312312312
{
    MyOneVC *csVC = [[MyOneVC alloc] init];
    [self pushViewController:csVC];
}


#pragma mark -----  调用safari分享功能将文件分享出去
- (void)createXLSFile
{
    // 创建存放XLS文件数据的数组
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    // 第一行内容
    [xlsDataMuArr addObject:@"Time"];
    [xlsDataMuArr addObject:@"Address"];
    [xlsDataMuArr addObject:@"Person"];
    [xlsDataMuArr addObject:@"Reason"];
    [xlsDataMuArr addObject:@"Process"];
    [xlsDataMuArr addObject:@"Result"];
    // 100行数据
    for (int i = 0; i < 100; i ++) {
        [xlsDataMuArr addObject:@"2016-12-06 17:18:40"];
        [xlsDataMuArr addObject:@"GuangZhou"];
        [xlsDataMuArr addObject:@"Mr.Liu"];
        [xlsDataMuArr addObject:@"Buy"];
        [xlsDataMuArr addObject:@"TaoBao"];
        [xlsDataMuArr addObject:@"Debt"];
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%6 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
    XPFLog(@"文件路径：\n%@",filePath);
    // 生成xls文件
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    
    [self ss:filePath];
}


- (void)ss:(NSString *)filePath
{
    // 调用safari分享功能将文件分享出去
    UIDocumentInteractionController *documentIc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    
    // 记得要强引用UIDocumentInteractionController,否则控制器释放后再次点击分享程序会崩溃
    self.documentIc = documentIc;
    
    // 如果需要其他safari分享的更多交互,可以设置代理
    documentIc.delegate = self;
    
    // 设置分享显示的矩形框
    CGRect rect = CGRectMake(0, 0, 300, 300);
    [documentIc presentOpenInMenuFromRect:rect inView:self.view animated:YES];
    [documentIc presentPreviewAnimated:YES];
}

@end
