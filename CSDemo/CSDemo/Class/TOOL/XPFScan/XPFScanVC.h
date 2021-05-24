// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFScanVC : UIViewController
///
@property (nonatomic, copy) NSString *type;
///
@property (nonatomic, copy) void(^hasScan)(NSString *codeInfo);

@end

NS_ASSUME_NONNULL_END

/*

 // 二维码
 XPFScanVC *vc = [[XPFScanVC alloc] init];
 vc.type = @"01";
 vc.hasScan = ^(NSString *codeInfo) {
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:codeInfo message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
     [alertView show];
     
 };
 vc.modalPresentationStyle = UIModalPresentationFullScreen;
 [self presentViewController:vc animated:YES completion:nil];

 // 条形码
 XPFScanVC *vc = [[XPFScanVC alloc] init];
 vc.type = @"02";
 vc.hasScan = ^(NSString *codeInfo) {
     
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:codeInfo message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
     [alertView show];
     
 };
 vc.modalPresentationStyle = UIModalPresentationFullScreen;
 [self presentViewController:vc animated:YES completion:nil];
 
 
 */
