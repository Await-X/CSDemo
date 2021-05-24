// 

#import "XPFAddRemarkView.h"

//static const int LimitMaxWord = 100;
 
@interface XPFAddRemarkView () <UITextViewDelegate> {
    int LimitMaxWord;
    CGFloat textViewHh;
    NSString *placeHolderStr;
}
 
/// 备注输入框
@property (nonatomic, weak) UITextView *txvRemark;
/// 备注placholder
@property (nonatomic, weak) UILabel *lblPlaceHolder;
/// 备注字数限制
@property (nonatomic, weak) UILabel *lblCount;
 
@end

@implementation XPFAddRemarkView

 
- (instancetype)initWithFrame:(CGRect)frame LimitMaxWord:(int)max placeHolder:(NSString *)phStr
{
    if (self == [super initWithFrame:frame]) {
        LimitMaxWord = max;
        textViewHh = frame.size.height;
        placeHolderStr = phStr;
        [self setSubView];
    }
    return self;
}
 
- (void)setSubView {
    /// 备注输入框
    UITextView *txvRemark = [[UITextView alloc]init];
    self.txvRemark = txvRemark;
    txvRemark.returnKeyType = UIReturnKeyDone;
    /// textview内
    txvRemark.textContainerInset = UIEdgeInsetsMake(12, 12, 25, 16);
    txvRemark.delegate = self;
    txvRemark.backgroundColor = [UIColor whiteColor];
    txvRemark.textColor = [UIColor blackColor];
    txvRemark.font = [UIFont systemFontOfSize:14];
    [self addSubview:txvRemark];
    [txvRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(textViewHh);
    }];
    
    /// 备注placholder
    UILabel *lblPlaceHolder = [[UILabel alloc]init];
    self.lblPlaceHolder = lblPlaceHolder;
    lblPlaceHolder.text = placeHolderStr;
    lblPlaceHolder.textColor = [UIColor grayColor];
    lblPlaceHolder.font = [UIFont systemFontOfSize:14];
    [self addSubview:lblPlaceHolder];
    [lblPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.equalTo(txvRemark.mas_top).offset(12);
        make.height.mas_equalTo(20);
    }];
    
    /// 备注字数限制(UITextView上添加不了view？？？)
    UILabel *lblCount = [[UILabel alloc]init];
    self.lblCount = lblCount;
    lblCount.textAlignment = NSTextAlignmentRight;
    lblCount.text = [NSString stringWithFormat:@"0/%d", LimitMaxWord];
    lblCount.textColor = [UIColor grayColor];
    lblCount.font = [UIFont systemFontOfSize:12];
    [self addSubview:lblCount];
    [lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(txvRemark.mas_right).offset(-16);
        make.width.mas_equalTo(60);
        make.bottom.equalTo(txvRemark.mas_bottom).offset(-5);
        make.height.mas_equalTo(20);
    }];
}
 
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.lblPlaceHolder.hidden = YES;
    
    if (textView.text.length > LimitMaxWord) {
        textView.text = [textView.text substringToIndex:LimitMaxWord];
    }
    /// 取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.lblPlaceHolder.hidden = NO;
    }
    
    /// 记录输入的字数，你若不统计字数，忽略这行
    self.lblCount.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)[textView.text length], LimitMaxWord];
}
 
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        /// 判断输入的字是否是回车，即按下return
        /// 在这里做你响应return键的代码
        [textView resignFirstResponder];
        /// 这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        return NO;
    }
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > LimitMaxWord){
        NSRange rangeIndex = [str rangeOfComposedCharacterSequenceAtIndex:LimitMaxWord];
        
        /// 字数超限
        if (rangeIndex.length == 1) {
            textView.text = [str substringToIndex:LimitMaxWord];
            /// 这里重新统计下字数，字数超限，我发现就不走textViewDidChange方法了，你若不统计字数，忽略这行
            self.lblCount.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)textView.text.length, LimitMaxWord];
        }else{
            NSRange rangeRange = [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, LimitMaxWord)];
            textView.text = [str substringWithRange:rangeRange];
        }
        return NO;
    }
    return YES;
}
 
 
@end
