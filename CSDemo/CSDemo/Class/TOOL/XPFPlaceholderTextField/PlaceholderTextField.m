//
//  PlaceholderTextField.m
//  YGVideo
//
//  Created by apple on 2020/12/29.
//  Copyright © 2020 YG. All rights reserved.
//

#import "PlaceholderTextField.h"
#import <objc/runtime.h>

@implementation PlaceholderTextField

- (void)changePlaceholder
{
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    Ivar ivarcolor = class_getInstanceVariable([UITextField class], "_placeholderLabel.textColor");
    Ivar ivarfont = class_getInstanceVariable([UITextField class], "_placeholderLabel.font");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.textColor = _placeholderColor;
    placeholderLabel.font = _placeholderFont;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self changePlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self changePlaceholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    [self changePlaceholder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
