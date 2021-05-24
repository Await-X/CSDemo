// 

#import "HomeCs2UIViewController.h"
#import "BaseWateCollectionLayout.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface HomeCs2UIViewController ()
<
UICollectionViewDelegate, UICollectionViewDataSource,
BaseWateCollectionLayoutDelegate
>
//
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HomeCs2UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试页面";
    //
    [self addCollectionView];
}

/*
 测试 二级页面
 
*/
- (void)addCollectionView {
    //UICollectionWaterLayout *layout = [UICollectionWaterLayout layoutWithColoumn:2 data:self.dataA verticleMin:10 horizonMin:10 leftMargin:10 rightMargin:10];
    BaseWateCollectionLayout *layout = [[BaseWateCollectionLayout alloc] init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    //cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"waterCell"];
    //注册区头
    //[self.collectionView registerClass:[XPFCollectionTopStopView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"topView"];
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.section == 0 ? [UIColor redColor] : [UIColor greenColor];
    return cell;
}
#pragma mark ---------  UICollectionView  Delegate/DataSource-----
//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

////配置区头
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionHeader) {
//        XPFCollectionTopStopView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topView" forIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor blackColor];
//        return headerView;
//    }
//    return nil;
//}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100; 
}

////设置区头高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(JkScreenWidth, 100);
//}


//设置区尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}



#pragma mark ----- BaseWateCollectionLayoutDelegate

- (CGSize)waterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-20)/2, 70);
}
/** 头视图Size */
-(CGSize )waterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 150);
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section
{
    return CGSizeMake(0.1, 0.1);
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout
{
    return 10;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout
{
    return 10;
}

/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(BaseWateCollectionLayout *)waterFlowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
