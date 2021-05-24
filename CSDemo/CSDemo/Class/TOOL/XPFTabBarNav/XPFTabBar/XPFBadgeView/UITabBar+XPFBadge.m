
#import "UITabBar+XPFBadge.h"
#import <objc/runtime.h>
#import "XPFBadgeView.h"

@interface UITabBar ()

@property (nonatomic, strong) NSMutableDictionary *badgeDict;

@end

@implementation UITabBar (XPFBadge)

- (NSMutableDictionary *)badgeDict
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:0];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN);
    }
    
    return dict;
}

- (XPFBadgeView *)badgeViewAtIndex:(NSInteger)index
{
    XPFBadgeView *badgeView =  [self.badgeDict objectForKey:@(index)];
    if (!badgeView && self.items.count > 0) {
        badgeView = [[XPFBadgeView alloc] init];
        
        [badgeView sizeToFit];
        
        float tabItemWidth = self.bounds.size.width / self.items.count;
        
        CGRect frame = badgeView.frame;
        frame.origin = CGPointMake(tabItemWidth * index + tabItemWidth / 2 + 2, 15);
        badgeView.frame = frame;
        
        [self addSubview:badgeView];
        
        [self.badgeDict setObject:badgeView forKey:@(index)];
    }
    
    return badgeView;
}

- (void)updateBadge:(NSString *)badgeValue bgColor:(UIColor *)bgColor atIndex:(NSInteger)index
{
    if (index >= 0 && index < self.items.count) {
        XPFBadgeView *badgeView = [self badgeViewAtIndex:index];
        
        if (badgeView) {
            badgeView.bgColor = bgColor;
            badgeView.badgeValue = badgeValue;
        }
    }
}

- (void)updateBadge:(NSString *)badgeValue atIndex:(NSInteger)index
{
    if (index >= 0 && index < self.items.count) {
        XPFBadgeView *badgeView = [self badgeViewAtIndex:index];
        
        if (badgeView) {
            badgeView.badgeValue = badgeValue;
        }
    }
}

- (void)updateBadgeTextColor:(UIColor *)textColor atIndex:(NSInteger)index
{
    if (index >= 0 && index < self.items.count) {
        XPFBadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.textColor = textColor;
        }
    }
}

- (void)updateBadgeBgColor:(UIColor *)bgColor atIndex:(NSInteger)index
{
    if (index >= 0 && index < self.items.count) {
        XPFBadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.bgColor = bgColor;
        }
    }
}

- (void)updateBadgeTextFont:(UIFont *)textFont atIndex:(NSInteger)index
{
    if (index >= 0 && index < self.items.count) {
        XPFBadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.textFont = textFont;
        }
    }
}


@end

