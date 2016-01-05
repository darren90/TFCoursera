//
//  SortController.m
//  TFCoursera
//
//  Created by Fengtf on 15/12/16.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "SortController.h"

#import "WaterCell.h"
//#import "MovieSearchApi.h"
//#import "SearchResultModel.h"
#import "HopperView.h"
#import "HopperSelBtn.h"
#import "HopperHeaderView.h"
#import "HopperModel.h"
#import "ItemButton.h"

/**
 *  选择view的高度
 */
static float KHopperViewH               = 140;
/**
 *  选择后btn的高度
 */
static float const KHopperSelectBtnH            = 40;
static float const KAnimateDurationTime            = 0.5;


@interface SortController ()<UICollectionViewDelegate,UICollectionViewDataSource,HopperViewDelegate,HopperHeaderViewDelegate>

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,weak)UICollectionView *waterView;

@property (nonatomic,assign)int page;

@property (nonatomic,assign)BOOL isRefreshing;


@property (nonatomic,weak)UICollectionViewFlowLayout * flowLayout;


@property (nonatomic,weak)HopperView * hopperView;
/**
 *  hopper的选择后的view
 */
@property (nonatomic,weak)HopperSelBtn *hopperSelBtn;
/**
 *  是否允许hopper出现
 */
@property (nonatomic,assign)BOOL isAllowHoppeAppear;

@property (nonatomic,weak)HopperHeaderView *headerView ;

@property (nonatomic,strong)NSMutableArray * mainArray;

/**
 *  第一次成功加载后的标记
 */
@property (nonatomic,assign)BOOL isData;
@end

@implementation SortController
static NSString *const IDENTTFIER = @"waterFlow";
static NSString *const HEADERIDENTTFIER = @"waterFlowheader";

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"全部分类";
    
    int row = self.mainArray.count % KRowCount  == 0 ? self.mainArray.count / KRowCount : self.mainArray.count / KRowCount + 1;
    
    KHopperViewH = kCollectionViewCellHeight*row + (row - 1) *  + 20;
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);//减去顶部NavBar64，底部TabBar49
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    UICollectionView * waterView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLayout];
    [waterView registerNib:[UINib nibWithNibName:@"WaterCell" bundle:nil] forCellWithReuseIdentifier:IDENTTFIER];
    [waterView registerClass:[HopperHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERIDENTTFIER];
    
    [self.view addSubview:waterView];
    
    waterView.backgroundColor = [UIColor whiteColor];
    waterView.delegate = self;
    waterView.dataSource = self;
    self.waterView = waterView;
    
    float ratio = 1.3 ;//宽高比 420.0
    int imgW = (self.view.frame.size.width - 2*(10+7)) / 3;
    int imgH = ratio * imgW + 47;
    
    flowLayout.itemSize = CGSizeMake(imgW, imgH);
    flowLayout.minimumLineSpacing = 10;// =70/3
    flowLayout.minimumInteritemSpacing = 7;
    //flowLayout.headerReferenceSize = CGSizeMake(10, 10);
    flowLayout.sectionInset = UIEdgeInsetsMake(40/3, 10, 10, 10);
   
    //第一次请求
    self.page = 1;
    self.isRefreshing = YES;
    [self requestData];
    
    [self initHopperSelectView];
    [self initHopperView];
}

-(void)initHopperSelectView
{
    if (self.hopperSelBtn)return;
    HopperSelBtn *hopperSelBtn = [HopperSelBtn buttonWithType:UIButtonTypeCustom];
    self.hopperSelBtn = hopperSelBtn;
    [self.view addSubview:hopperSelBtn];
    hopperSelBtn.frame = CGRectMake(0, 64 - KHopperSelectBtnH,self.view.frame.size.width, KHopperSelectBtnH);
    [hopperSelBtn setTitle:@"全部" forState:UIControlStateNormal];
    [hopperSelBtn addTarget:self action:@selector(hopperSelBtndidClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initHopperView
{
    if (self.hopperView) return;
    HopperView *hopperView = [[HopperView alloc]init];
    self.hopperView = hopperView;
    hopperView.frame = CGRectMake(0, -KHopperViewH, self.view.frame.size.width, KHopperViewH);
    [self.view addSubview:hopperView];
    hopperView.delegate = self;
    self.hopperView.mainArray = self.mainArray;
}

-(void)hopperSelBtndidClick
{
    self.isAllowHoppeAppear = YES;
    self.hopperSelBtn.hidden = YES;
    self.hopperView.hidden = NO;
    //    [self.hopperView reloadView];
    [UIView animateWithDuration:KAnimateDurationTime+0.2 animations:^{
        self.hopperView.transform = CGAffineTransformMakeTranslation(0, KHopperViewH + 64);
    }];
}

#pragma mark - HopperView的代理，选择好item后的代理
-(void)HopperViewItemDidSelect:(NSString *)text
{
    self.hopperSelBtn.selectTitle = text;
    [self.headerView reloadView];
 
}
#pragma mark - HopperHeaderView的代理，选择好item后的代理 -- 上面的会调用这个方法
-(void)HopperHeaderViewItemDidSelect:(NSString *)text index:(NSInteger)index
{
    self.hopperSelBtn.selectTitle = text;
    [self.hopperView refreshHooper:index];
    
    if (self.isRefreshing == NO) {
        self.page = 1;
        self.isRefreshing = YES;
        [self requestDataWithText:text];
    }
    
        [self.waterView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        [self.waterView reloadData];
}

#pragma - mark 滚到顶部
- (void)scrollToTop
{
    [self.waterView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

-(void)requestData
{

}

-(void)requestDataWithText:(NSString *)text
{
    NSLog(@"---:search text:%@",text);
}

#pragma  - mark 视频搜索界面
- (void)rightBtnClick
{
    [self performSegueWithIdentifier:@"movieSearch" sender:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;//self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTTFIER forIndexPath:indexPath];
//    cell.searchModel = self.dataArray[indexPath.item];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        HopperHeaderView *headerView =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                           withReuseIdentifier:HEADERIDENTTFIER
                                                  forIndexPath:indexPath];
        headerView.delegate = self;
        if (self.isData == NO) {
            headerView.mainArray = self.mainArray;
            self.isData = YES;
        }
        self.headerView = headerView;
        return (UICollectionReusableView *)headerView;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, KHopperViewH);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isAllowHoppeAppear = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= KHopperViewH) {
        [UIView animateWithDuration:KAnimateDurationTime animations:^{
            self.hopperSelBtn.transform = CGAffineTransformMakeTranslation(0,KHopperSelectBtnH);
        }];
    }else{
        [UIView animateWithDuration:KAnimateDurationTime animations:^{
            self.hopperSelBtn.transform = CGAffineTransformMakeTranslation(0,-KHopperSelectBtnH);
        }];
    }
    if(self.isAllowHoppeAppear) return;
    self.hopperSelBtn.hidden = NO;
    self.hopperView.hidden = YES;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(NSMutableArray *)mainArray
{
    if (_mainArray == nil) {
        _mainArray = [NSMutableArray array];
        HopperModel *m1 = [HopperModel hopperWithTitle:@"全部" isSelect:YES];
        HopperModel *m2 = [HopperModel hopperWithTitle:@"喜剧" isSelect:NO];
        HopperModel *m3 = [HopperModel hopperWithTitle:@"动作" isSelect:NO];
        HopperModel *m4 = [HopperModel hopperWithTitle:@"科幻" isSelect:NO];
        HopperModel *m5 = [HopperModel hopperWithTitle:@"恐怖" isSelect:NO];
        HopperModel *m6 = [HopperModel hopperWithTitle:@"剧情" isSelect:NO];
        HopperModel *m7 = [HopperModel hopperWithTitle:@"罪案" isSelect:NO];
        HopperModel *m8 = [HopperModel hopperWithTitle:@"冒险" isSelect:NO];
        HopperModel *m9 = [HopperModel hopperWithTitle:@"悬疑" isSelect:NO];
        HopperModel *m10 = [HopperModel hopperWithTitle:@"魔幻" isSelect:NO];
        [_mainArray addObjectsFromArray: @[m1,m2,m3,m4,m10,m5,m6,m7,m8,m9]];
    }
    return _mainArray;
}
@end