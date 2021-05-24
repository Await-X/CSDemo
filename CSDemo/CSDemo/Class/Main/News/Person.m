// 消息

#import "Person.h"
#import <objc/runtime.h>
#import "SpareWheel.h"

@implementation Person

void sendMessage(id self, SEL _cmd, NSString *msg)
{
    NSLog(@" ------- %@ ,", msg);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
//    // 1、匹配方法
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        return class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
//    }
    return NO;
}

/// 快速转发
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    // 1、匹配方法
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        return [SpareWheel new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}


/// 慢速转发

// 1、方法签名
// 2、消息转发

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
//    SEL sel = [anInvocation selector];
//    SpareWheel *tempObj = [SpareWheel new];
//    if ([tempObj respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:tempObj];
//    }
//    else
//    {
//        [super forwardInvocation:anInvocation];
//    }
    [super forwardInvocation:anInvocation];
}



- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@" 找不到方法 ");
}

@end
