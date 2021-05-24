// 

#import "TimerTool.h"

@implementation TimerTool

+ (void)ss
{
    CADisplayLink *disLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(test)];
    [disLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //每秒钟调用多次 默认60.
    if (@available(iOS 10.0, *)) {
        disLink.preferredFramesPerSecond = 60;
    } else {
        // Fallback on earlier versions
    }
    //是否暂停
    disLink.paused = NO;
}

- (void)test
{
    NSLog(@"测试");
}

@end
