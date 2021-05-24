// 

#import "XPFUploadProductVC.h"
//
#import "XPFUploadProduct.h"

@interface XPFUploadProductVC ()
/// 添加商品 view
@property (nonatomic, strong) XPFUploadProduct *addproductView;

@end

@implementation XPFUploadProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"添加商品";
    //self.view.backgroundColor =  // 统一背景色
    [self.view addSubview:self.addproductView];
    [self.addproductView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(64); // 64 这个地方你自己的宏定义
    }];
    
}

/**
 *
 */
- (XPFUploadProduct *)addproductView
{
    if (!_addproductView) {
        _addproductView = [[XPFUploadProduct alloc] init];
        _addproductView.backgroundColor = [UIColor grayColor];
    }
    return _addproductView;
}

@end
