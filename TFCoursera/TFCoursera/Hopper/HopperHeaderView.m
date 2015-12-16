//
//  HopperHeaderView.m
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import "HopperHeaderView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "CollectionViewCell.h"
#import "HopperModel.h"

//static float const kControllerHeaderViewHeight                = 90.f;
//static float const kControllerHeaderToCollectionViewMargin    = 0;
//static float const kCollectionViewCellsHorizonMargin          = 10;
//static float const kCollectionViewCellHeight                  = 30;
////static float const kCollectionViewItemButtonImageToTextMargin = 5;
//static float const kCollectionViewToLeftMargin                = 16;
//static float const kCollectionViewToTopMargin                 = 0;
//static float const kCollectionViewToRightMargin               = 16;
//static float const kCollectionViewToBottomtMargin             = 10;
//static float const kCellBtnCenterToBorderMargin               = 19;


static NSString * const kCellIdentifier           = @"CellIdentifier";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";

typedef void(^ISLimitWidth)(BOOL yesORNo,id data);


@interface HopperHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
//@property (nonatomic,strong)NSMutableArray * mainArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,weak)ItemButton * selectBtn;

@end

@implementation HopperHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
        
        [self addCollectionView];
    }
    return self;
}

- (void)addCollectionView {
    CGRect collectionViewFrame = CGRectMake(0, kControllerHeaderViewHeight + kControllerHeaderToCollectionViewMargin, [UIScreen mainScreen].bounds.size.width,
                                            [UIScreen mainScreen].bounds.size.height-40);
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

-(void)setMainArray:(NSArray *)mainArray
{
    _mainArray = mainArray;
    
//    [self.collectionView reloadData];
}

-(void)reloadView
{
    [self.collectionView reloadData];
}


#pragma mark - 🔌 UICollectionViewDataSource Method
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.mainArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =
    (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                    forIndexPath:indexPath];
    HopperModel *model = self.mainArray[indexPath.item];
    NSString *text = model.title;
    cell.title = text;
    [cell.button addTarget:self action:@selector(itemButtonClicked:)
          forControlEvents:UIControlEventTouchDown];
    cell.button.section = indexPath.section;
    cell.button.row = indexPath.row;
    if (model.isSelect) {
        [self itemButtonClicked:cell.button];
    }
    return cell;
}

#pragma mark - 🎬 Actions Method
- (void)itemButtonClicked:(ItemButton *)button {
    self.selectBtn.selected = NO;
    self.selectBtn = button;
    button.selected = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:button.row inSection:button.section];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - 🔌 UICollectionViewDelegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HopperModel *model = self.mainArray[indexPath.item];
    NSString *text = model.title;
    for (HopperModel *m in self.mainArray) {
        m.isSelect = NO;
    }
    model.isSelect = YES;
//    NSLog(@"-header-item-sele:%@",text);
    
    if ([self.delegate respondsToSelector:@selector(HopperHeaderViewItemDidSelect:index:)]) {
        [self.delegate HopperHeaderViewItemDidSelect:text index:indexPath.item];
    }
}

//- (BOOL)shouldCollectionCellPictureShowWithIndex:(NSIndexPath *)indexPath {
//    NSMutableArray *symptoms = [NSMutableArray arrayWithArray:[self.mainArray[indexPath.section] objectForKey:kDataSourceSectionKey]];
//    NSString *picture = [symptoms[indexPath.row] objectForKey:kDataSourceCellPictureKey];
//    NSUInteger pictureLength = [@(picture.length) integerValue];
//    if(pictureLength > 0) {
//        return YES;
//    }
//    return NO;
//}

#pragma mark - 🔌 UICollectionViewDelegateLeftAlignedLayout Method

/**
 *  返回cell的宽高
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HopperModel *model = self.mainArray[indexPath.item];
    NSString *text = model.title;
    float cellWidth = [self collectionCellWidthText:text];
    cellWidth = (KWidth - kCollectionViewCellsHorizonMargin - (KRowCount-1)*kCollectionViewCellsHorizonMargin -kCollectionViewToLeftMargin -kCollectionViewToRightMargin)/ KRowCount;
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

/**
 *  返回cell的左右间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;
}
/**
 *  返回cell的上下间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;
}

/**
 *  返回所有cell四周的间距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

/**
 *  Headerview的大小
 */
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 0);
//}

- (float)collectionCellWidthText:(NSString *)text{
    float cellWidth;
    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin * 2;
    cellWidth = [self cellLimitWidth:cellWidth limitMargin:0 isLimitWidth:nil];
    return cellWidth;
}
- (float)cellLimitWidth:(float)cellWidth limitMargin:(CGFloat)limitMargin isLimitWidth:(ISLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - limitMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth?isLimitWidth(YES,@(cellWidth)):nil;
        return cellWidth;
    }
    isLimitWidth?isLimitWidth(NO,@(cellWidth)):nil;
    return cellWidth;
}


//-(NSMutableArray *)mainArray
//{
//    if (_mainArray == nil) {
//        _mainArray = [NSMutableArray array];
//        HopperModel *m1 = [HopperModel hopperWithTitle:@"全部" isSelect:YES];
//        HopperModel *m2 = [HopperModel hopperWithTitle:@"喜剧" isSelect:NO];
//        HopperModel *m3 = [HopperModel hopperWithTitle:@"动作" isSelect:NO];
//        HopperModel *m4 = [HopperModel hopperWithTitle:@"科幻" isSelect:NO];
//        HopperModel *m5 = [HopperModel hopperWithTitle:@"恐怖" isSelect:NO];
//        HopperModel *m6 = [HopperModel hopperWithTitle:@"剧情" isSelect:NO];
//        HopperModel *m7 = [HopperModel hopperWithTitle:@"罪案" isSelect:NO];
//        HopperModel *m8 = [HopperModel hopperWithTitle:@"冒险" isSelect:NO];
//        HopperModel *m9 = [HopperModel hopperWithTitle:@"悬疑" isSelect:NO];
//        [_mainArray addObjectsFromArray: @[m1,m2,m3,m4,m5,m6,m7,m8,m9]];
//    }
//    return _mainArray;
//}

@end
