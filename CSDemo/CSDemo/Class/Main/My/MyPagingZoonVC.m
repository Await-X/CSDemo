// 

#import "MyPagingZoonVC.h"


@implementation MyPagingZoonVC


- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}


@end
