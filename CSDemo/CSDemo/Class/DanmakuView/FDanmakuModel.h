// 

#import <Foundation/Foundation.h>
#import "FDanmakuModelProtocol.h"

@interface FDanmakuModel : NSObject <FDanmakuModelProtocol>

@property (nonatomic, assign) NSTimeInterval beginTime;
@property (nonatomic, assign) NSTimeInterval liveTime;

//@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSMutableAttributedString *content;
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *beanNuber;
@property (nonatomic, copy) NSString *textid;
@property (nonatomic, assign) NSInteger textTag;
@property (nonatomic, assign) NSInteger topImgTag;

@end
