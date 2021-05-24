//

#import "XPFBaseViewController.h"

@interface XPFBaseViewController ()

@end

@implementation XPFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *
 */
- (void)pushViewController:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}


@end
