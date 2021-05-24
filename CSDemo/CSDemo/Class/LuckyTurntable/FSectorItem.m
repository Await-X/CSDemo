/*
 扇形 item
 
 它的大小
 
 */

#import "FSectorItem.h"

//static int radius = 150;

@interface FSectorItem ()

@end

@implementation FSectorItem

//
- (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

// 计算度转弧度
static inline float radians(double degrees) {
    return degrees * M_PI / 180;
}

/**
 *  计算度转弧度
 *  CGRect ：rect
 *  CGContextRef ：ctx
 *  CGPoint ：point
 *  float ：angle_start  开始角度
 *  float ：angle_end 结束角度
 *  UIColor :  ordinaryColor 普通 颜色
 *  int ：ordinaryIndex 普通 每个item
 *  UIColor : appointColor 指定颜色
 *  int ：appointIndex 指定 item
 */
static inline void drawArc (CGContextRef ctx, CGPoint point, CGFloat radius, float angle_start, float angle_end, UIColor *ordinaryColor, int ordinaryIndex, UIColor *appointColor, int appointIndex)
{
    CGContextMoveToPoint(ctx, point.x, point.y);
    if (ordinaryIndex == appointIndex)
    {// 指定某个背景色颜色
        CGContextSetFillColorWithColor(ctx, [appointColor CGColor]);
    }
    else
    {// 赋值颜色
        if (ordinaryIndex % 2 == 0)
        {
            CGContextSetFillColorWithColor(ctx, [[UIColor yellowColor] CGColor]);
        }
        else
        {
            CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
        }
    }
    //CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextAddArc(ctx, point.x, point.y, radius, angle_start, angle_end, 0); //绘制方向，0 顺时针，1 逆时针
    //CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
}

- (void)drawRect:(CGRect)rect
{
    CGPoint cent = CGPointMake((self.frame.size.width/2), (self.frame.size.height/2));
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    NSInteger contAry = self.itemAry.count;
    for (int i = 0; i < contAry; i++) {
        //
        FItemModel *model = self.itemAry[i];
        //
        float rawww = 360 / contAry; // 间距 每个角度
        float raqsd = 90.0 + rawww/2; // 12点钟的位置 ,不减去这个角度在3点钟的位置
        float raxxx = i * rawww - raqsd; // 起点 12点钟的位置
        float angle_start = radians(raxxx);
        float angle_end = radians(rawww + raxxx);
        //XPFLog(@" 这里 %d, 起始： %f, 结束： %f", i, raxxx, rawww + raxxx);
        drawArc(ctx, cent, self.radius, angle_start, angle_end, [UIColor whiteColor], i, [UIColor redColor], 2);
        
        // -----
        double EA = RATIOA(30); //
        double ab = self.radius - EA;
        double ac = sin(rawww) * ab;
        double bc = sqrt(ab*ab - ac*ac);
        
        //double ab = sqrt(bc*bc + ac*ac);
        //NSLog(@" ac => %f, bc => %f, ab => %f", ac, bc, ab);
        
        // ----------
        
        double itmeWw = M_PI * CGRectGetHeight(self.bounds)/contAry;
        double itmeHh = CGRectGetHeight(self.bounds)/2;
        
        double WwSame = RATIOA(25); // 图片 宽 点击按钮 宽*2
        if (bc <= WwSame) { // 处理文本每行只显示一个字
            bc = WwSame*2;
        }
        if (bc > itmeWw) {
            bc = itmeWw - RATIOA(5);
        }
        
        UIView *itmeBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itmeWw, itmeHh)];
        //FMenuView *itmeBGView = [[FMenuView alloc] initWithFrame:CGRectMake(0, 0, M_PI * CGRectGetHeight(self.bounds)/contAry, CGRectGetHeight(self.bounds)/2)];
        CGFloat angle = M_PI * 2 / contAry * i;
        itmeBGView.transform = CGAffineTransformMakeRotation(angle);
        itmeBGView.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        itmeBGView.layer.anchorPoint = CGPointMake(0.5, 1);
        itmeBGView.userInteractionEnabled = YES;
        [self addSubview:itmeBGView];
        
        //
        UILabel *itmeText = [[UILabel alloc] init];
        [itmeBGView addSubview:itmeText];
        [itmeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(EA);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(bc);
        }];
        itmeText.text = [NSString stringWithFormat:@"%@", model.textStr];
        itmeText.textAlignment = NSTextAlignmentCenter;
        itmeText.font = [UIFont systemFontOfSize:10];
        itmeText.numberOfLines = 0;
        
        //
        UIImageView *itmeImg = [[UIImageView alloc] init];
        [itmeBGView addSubview:itmeImg];
        [itmeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(itmeText.mas_bottom).offset(RATIOA(15));
            make.width.height.mas_equalTo(WwSame);
        }];
        itmeImg.image = [UIImage imageNamed:model.imgStr];//@"icon_heart_3"];
        //
        UIButton *itmeBtn = [[UIButton alloc] init];
        [itmeBGView addSubview:itmeBtn];
        [itmeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(itmeImg.mas_bottom);
            make.top.mas_equalTo(0);//(itmeText.mas_top).offset(RATIOA(-15));
            make.width.mas_equalTo(WwSame*2);
        }];
        //itmeBtn.backgroundColor = [UIColor grayColor];
        itmeBtn.tag = 30002000 + i;
        [itmeBtn addTarget:self action:@selector(actionDidClickindex:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
}

- (void)actionDidClickindex:(UIButton *)button
{
    NSInteger index = button.tag - 30002000;
    FItemModel *model = self.itemAry[index];
    XPFLog(@" ====== 点击了 %ld item ====== 标题：%@", index, model.textStr);

}


@end
