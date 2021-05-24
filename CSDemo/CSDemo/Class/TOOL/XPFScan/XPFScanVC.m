//

#import "XPFScanVC.h"
#import <AVFoundation/AVFoundation.h>

@interface XPFScanVC ()
<
AVCaptureMetadataOutputObjectsDelegate
>
///
@property (nonatomic, strong) AVCaptureSession *session;
///
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation XPFScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    [self getRequest];
    // 
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
    [_backBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
    [_backBtn setBackgroundColor:[UIColor grayColor]];
    [_backBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_backBtn addTarget:self action:@selector(onBackAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_backBtn];
}

- (void)getRequest {
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (granted) {
                
                [self setupScan];
                
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有权限" message:@"" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            }
            
        });
    }];
    
}

- (void)setupScan {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    
    //qrcode
    if ([self.type isEqualToString:@"01"])
    {
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //barcode
    }
    else if ([self.type isEqualToString:@"02"])
    {
        
        output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeUPCECode,
                                       AVMetadataObjectTypeCode39Code,
                                       AVMetadataObjectTypeCode39Mod43Code,
                                       AVMetadataObjectTypeCode93Code,
                                       AVMetadataObjectTypeCode128Code,
                                       AVMetadataObjectTypePDF417Code];
        
    }
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:10003];
    
    [self.session startRunning];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *result = metadataObject.stringValue;
        
        self.hasScan(result);
        [self.session stopRunning];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onBackAction
{
    [self.session stopRunning];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
