//
//  HopperView.m
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import "HopperView.h"
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


@interface HopperView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,weak)ItemButton * selectBtn;

@end

@implementation HopperView

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
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    [self.collectionView reloadData];
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

//#pragma mark - 🔌 UICollectionViewDataSource Method
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return [self.mainArray count];
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
//    NSArray *symptoms = [NSArray arrayWithArray:[self.dataSource[section] objectForKey:kDataSourceSectionKey]];
//    for (NSNumber *i in self.expandSectionArray) {
//        if (section == [i integerValue]) {
//            return [symptoms count];
//        }
//    }
//    return [self.firstRowCellCountArray[section] integerValue];
      return [self.mainArray count];
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =
    (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                    forIndexPath:indexPath];
    cell.button.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
//    NSMutableArray *symptoms = [NSMutableArray arrayWithArray:[self.mainArray[indexPath.section]
//                                                               objectForKey:kDataSourceSectionKey]];
//    NSString *text = self.mainArray[indexPath.item];
    HopperModel *model = self.mainArray[indexPath.item];
    NSString *text = model.title;
    
    //[symptoms[indexPath.row] objectForKey:kDataSourceCellTextKey];
    cell.title = text;
//    [cell.button addTarget:self action:@selector(itemButtonClicked:)
//          forControlEvents:UIControlEventTouchUpInside];
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
    NSLog(@"but--sel-:%p",button);
    self.selectBtn.selected = NO;
    self.selectBtn = button;
    button.selected = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:button.row inSection:button.section];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

-(void)refreshHooper:(NSInteger)index
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
//    NSInteger oldItem = 0;
//    if (self.selectBtn) {
//        oldItem = self.selectBtn.row;
//    }
//    NSIndexPath *oldPath = [NSIndexPath indexPathForItem:oldItem inSection:0];
    for (HopperModel *m in self.mainArray) {
        m.isSelect = NO;
    }
    HopperModel *newModel = self.mainArray[index];
    newModel.isSelect = YES;
 
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:path];
    self.selectBtn.selected = NO;
    cell.button.selected = YES;
    self.selectBtn = cell.button;
    
    NSLog(@"-rrrr-bb0-tt:%@--",cell.title);
}

#pragma mark - 🔌 UICollectionViewDelegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *text = self.mainArray[indexPath.item];
    HopperModel *model = self.mainArray[indexPath.item];
    NSString *text = model.title;
     NSLog(@"-item-sele:%@",text);
    for (HopperModel *m in self.mainArray) {
        m.isSelect = NO;
    }
    model.isSelect = YES;
    
    if ([self.delegate respondsToSelector:@selector(HopperViewItemDidSelect:)]) {
        [self.delegate HopperViewItemDidSelect:text];
    }
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    NSIndexPath *path = [NSIndexPath indexPathForItem:selectIndex inSection:0];
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:path];
    NSLog(@"-sel-bb0-tt:%@",cell.title);
    [self itemButtonClicked:cell.button];
//    [self.collectionView reloadItemsAtIndexPaths:@[path]];
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    //二级菜单数组
//    NSArray *symptoms = [NSArray arrayWithArray:[self.mainArray[indexPath.section]
//                                                 objectForKey:kDataSourceSectionKey]];
//    NSString *sectionTitle = [self.dataSource[indexPath.section] objectForKey:@"Type"];
//    BOOL shouldShowPic = [self shouldCollectionCellPictureShowWithIndex:indexPath];
//    NSString *cellTitle = [symptoms[indexPath.row] objectForKey:kDataSourceCellTextKey];
//    NSString *message = shouldShowPic?[NSString stringWithFormat:@"★%@",cellTitle]:cellTitle;
//    
//    NSLog(@"-item-sele:%@-%@",sectionTitle,message);
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind
//                                 atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
//        CYLFilterHeaderView *filterHeaderView =
//        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                                           withReuseIdentifier:kHeaderViewCellIdentifier
//                                                  forIndexPath:indexPath];
//        filterHeaderView.moreButton.hidden =
//        
//        filterHeaderView.delegate = self;
//        NSString *sectionTitle = [self.dataSource[indexPath.section] objectForKey:@"Type"];
//        filterHeaderView.titleButton.tag = indexPath.section;
//        filterHeaderView.moreButton.tag = indexPath.section;
//        filterHeaderView.moreButton.selected = NO;
//        [filterHeaderView.titleButton setTitle:sectionTitle forState:UIControlStateNormal];
//        [filterHeaderView.titleButton setTitle:sectionTitle forState:UIControlStateSelected];
//        for (NSNumber *i in self.expandSectionArray) {
//            if (indexPath.section == [i integerValue]) {
//                filterHeaderView.moreButton.selected = YES;
//            }
//        }
//        return (UICollectionReusableView *)filterHeaderView;
//    }
//    return nil;
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
    cellWidth = (self.frame.size.width - kCollectionViewCellsHorizonMargin - (KRowCount-1)*kCollectionViewCellsHorizonMargin -kCollectionViewToLeftMargin -kCollectionViewToRightMargin)/ KRowCount;
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
 

@end
