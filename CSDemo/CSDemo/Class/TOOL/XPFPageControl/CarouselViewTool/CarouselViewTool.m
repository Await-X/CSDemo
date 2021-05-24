// 

#import "CarouselViewTool.h"
//#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "PageControlTool.h"

static const int imageBtnCount = 3;

@interface CarouselViewTool () <UIScrollViewDelegate>
///
@property (nonatomic, strong) UIScrollView *scrollView;
///
//@property (nonatomic, strong) PageControlTool *pageControl;
@property (nonatomic, strong) UIPageControl *pageControl;
///
//@property (nonatomic, strong) UILabel *countLabel;
///
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CarouselViewTool

//- (instancetype)init {
//    if (self = [super init]) {
//        [self initViews];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.originIV = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.originIV];
    
    //定义一个scrollView，最主要的轮播控件
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    //横竖两种滚轮都不显示
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    //需要分页
    scrollView.pagingEnabled = YES;
    //不需要回弹（试了一下加不加应该都没什么影响）
    scrollView.bounces = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //在scrollView中添加三个图片按钮，因为后面需要响应点击事件，所以我直接用按钮不用imageView了，感觉更方便一些
    for (int i = 0; i < imageBtnCount; i++) {
        UIImageView *imageBtn = [[UIImageView alloc] init];
        imageBtn.tag = i;
        [scrollView addSubview:imageBtn];
    }
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
//    self.pageControl = [[PageControlTool alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - 20, 100, 13)];
//    [self addSubview:self.pageControl];
//    self.pageControl.backgroundColor = [UIColor clearColor];
//    self.pageControl.center = CGPointMake(self.pageControl.superview.center.x, self.pageControl.center.y);
//
//    self.pageControl.cornerRadius = 5;
//    self.pageControl.dotSpace = 10;
//    self.pageControl.currentDotWidth = 20;
//    self.pageControl.otherDotWidth = 10;
//    self.pageControl.dotHeight = 10;
//    self.pageControl.otherDotColor = [UIColor whiteColor];
//    self.pageControl.currentDotColor = [UIColor orangeColor];
//    self.pageControl.numberOfPages = 5;

    //self.pageControl.hidden = YES;
    /*
    self.countLabel = [[UILabel alloc] init];
    [self addSubview:self.countLabel];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.font = YGFONT(15);
    self.countLabel.textAlignment = 1;
    self.countLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.countLabel.layer.cornerRadius = 10;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.text = @"1/5";
    */
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置scrollView的frame
    self.scrollView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    //设置contentSize,不同轮播方向的时候contentSize是不一样的
    if (self.isScrollDorectionPortrait)
    { //竖向
        //contentSize要放三张图片
        self.scrollView.contentSize = CGSizeMake(width, height * imageBtnCount);
    }
    else
    { //横向
        self.scrollView.contentSize = CGSizeMake(width * imageBtnCount, height);
    }
    //设置三张图片的位置，并为三个按钮添加点击事件
    for (int i = 0; i < imageBtnCount; i++)
    {
        UIImageView *imageBtn = self.scrollView.subviews[i];
        imageBtn.userInteractionEnabled = YES;
        imageBtn.tag = i;
        UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageBtnClick:)];
        [imageBtn addGestureRecognizer:tapGester];
        
        if (self.isScrollDorectionPortrait)
        { //竖向
            imageBtn.frame = CGRectMake(0, i * height, width, height);
        }
        else
        { //横向
            imageBtn.frame = CGRectMake(i * width, 0, width, height);
        }
    }
    //设置contentOffset,显示最中间的图片
    if (self.isScrollDorectionPortrait) { //竖向
        self.scrollView.contentOffset = CGPointMake(0, height);
    } else { //横向
        self.scrollView.contentOffset = CGPointMake(width, 0);
    }
    
    //设置pageControl的位置
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = width - pageW;
    CGFloat pageY = height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
//    CGFloat labelW = 50;
//    CGFloat labelH = 25;
//    CGFloat labelX = width - labelW - 15;
//    CGFloat labelY = height - labelH - 15;
//    self.countLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}
//设置pageControl的CurrentPageColor
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
//    self.pageControl.currentDotColor = currentPageColor;
}
//设置pageControl的pageColor
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
//    self.pageControl.otherDotColor = pageColor;
}

//根据传入的图片数组设置图片
- (void)setImages:(NSArray *)images
{
    _images = images;
    if (images.count == 0) {
        self.scrollView.scrollEnabled = NO;
        return;
    }
    self.scrollView.scrollEnabled = YES;

    //pageControl的页数就是图片的个数
    self.pageControl.numberOfPages = (int)images.count;
    //默认一开始显示的是第0页
    self.pageControl.currentPage = 0;
    
//    self.countLabel.text = [NSString stringWithFormat:@"1/%ld",images.count];
    
    //设置图片显示内容
    [self setContent];
    //开启定时器
//    [self startTimer];
    
}
//设置显示内容
- (void)setContent
{
    //设置三个imageBtn的显示图片
    NSInteger subviewCount = self.scrollView.subviews.count;
    for (int i = 0; i < subviewCount; i++) {
        //取出三个imageBtn
        UIImageView *imageBtn = self.scrollView.subviews[i];
        //这个是为了给图片做索引用的
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) { //第一个imageBtn，隐藏在当前显示的imageBtn的左侧
            index--; //当前页索引减1就是第一个imageBtn的图片索引
        } else if (i == 2) { //第三个imageBtn，隐藏在当前显示的imageBtn的右侧
            index++; //当前页索引加1就是第三个imageBtn的图片索引
        }
        //无限循环效果的处理就在这里
        if (index < 0) { //当上面index为0的时候，再向右拖动，左侧图片显示，这时候我们让他显示最后一张图片
            index = self.pageControl.numberOfPages - 1;
        } else if (index == self.pageControl.numberOfPages) { //当上面的index超过最大page索引的时候，也就是滑到最右再继续滑的时候，让他显示第一张图片
            index = 0;
        }
        imageBtn.tag = index;
        imageBtn.contentMode = UIViewContentModeScaleAspectFill; // 填充
        imageBtn.clipsToBounds = YES; // 裁剪
        //imageBtn.image = [UIImage imageNamed:@""]; // 占位
        if (self.images.count == 0) return;
        NSString *imgStr = [self.images firstObject];
        if ([imgStr hasPrefix:@"http"])
        {
            [imageBtn sd_setImageWithURL:[NSURL URLWithString:self.images[index]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageAllowInvalidSSLCertificates];
        }
        else
        {
            imageBtn.image = [UIImage imageNamed:self.images[index]];
        }
    }
}
//状态改变之后更新显示内容
- (void)updateContent
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self setContent];
    //唯一跟设置显示内容不同的就是重新设置偏移量，让它永远用中间的按钮显示图片,滑动之后就偷偷的把偏移位置设置回去，这样就实现了永远用中间的按钮显示图片
    //设置偏移量在中间
    if (self.isScrollDorectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, height);
    } else {
        self.scrollView.contentOffset = CGPointMake(width, 0);
    }
}

#pragma mark - UIScrollViewDelegate
//拖拽的时候执行哪些操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //拖动的时候，哪张图片最靠中间，也就是偏移量最小，就滑到哪页
    //用来设置当前页
    NSInteger page = 0;
    //用来拿最小偏移量
    CGFloat minDistance = MAXFLOAT;
    //遍历三个imageView,看那个图片偏移最小，也就是最靠中间
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageBtn = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDorectionPortrait) {
            distance = ABS(imageBtn.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageBtn.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageBtn.tag;
        }
    }
//    self.pageControl.currentPage = (self.pageControl.currentPage + 1 + self.pageControl.numberOfPages) % self.pageControl.numberOfPages;
    self.pageControl.currentPage = (int)page;
    
//    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",page+1,self.images.count];
    
}
//开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
//结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}
//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}
#pragma mark - 定时器
//开始计时器
- (void)startTimer
{
    if (self.images.count == 1)
    {
        return;
    }
    [self stopTimer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
//停止计时器
- (void)stopTimer {
    //结束计时
    [self.timer invalidate];
    //计时器被系统强引用，必须手动释放
    self.timer = nil;
}
//通过改变contentOffset * 2换到下一张图片
- (void)nextImage {
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    if (self.isScrollDorectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
    }
}

- (void)imageBtnClick:(UITapGestureRecognizer *)sender {
    UIView *imageView = sender.view;
    if ([self.delegate respondsToSelector:@selector(carouselView:indexOfClickedImageBtn:)]) {
        [self.delegate carouselView:self indexOfClickedImageBtn:imageView.tag];
    }
    
}

- (UIImageView *)imageViewWithIndex:(NSInteger)index {
    return (UIImageView *)self.scrollView.subviews[index];
}

@end
