// 

#import "XPFTabBar.h"

@interface XPFTabBar ()
///
@property (nonatomic, strong) UIButton *middleBtn;
///
@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation XPFTabBar

/*
///
- (void)layoutSubviews {
    [super layoutSubviews];
    //
    [self addSubview:self.sendBtn];
    //
    [self.sendBtn setImagePositionWithType:SSImagePositionTypeBottom spacing:4]; //
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / self.tabBarNumber;
            view.x = self.width * j / self.tabBarNumber;
            j++;
            if (j == 2) {
                j++;
            }
        }
    }
    
}
// 发布
- (void)didClickPublishBtn:(UIButton*)sender {
    if (self.didMiddBtn) {
        self.didMiddBtn();
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.middleBtn];
        if ([self.middleBtn pointInside:newP withEvent:event]) {
            return self.middleBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setImage:[UIImage imageNamed:@"videoImg"] forState:UIControlStateNormal];
        //[_sendBtn setTitl e:@"发布" forState:UIControlStateNormal];
        //_sendBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_sendBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.adjustsImageWhenHighlighted = NO;
        _sendBtn.size = CGSizeMake(self.bounds.size.width / self.tabBarNumber, 70);
        _sendBtn.centerX = self.width / 2;
        _sendBtn.centerY = 12;
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.middleBtn = _sendBtn;
    }
    return _sendBtn;
}
 
 
 */

@end
