/*
 消息转发机制
 1、动态方法解析 (resolveInstanceMethod)
 2、快速转发 (forwardingTargetForSelector)
 3、慢速转发
    3-1、方法签名 (methodSignatureForSelector)
    3-2、消息转发 (forwardInvocation)
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)sendMessage:(NSString *)mesg;

@end

NS_ASSUME_NONNULL_END
