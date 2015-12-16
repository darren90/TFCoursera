//
//  ItemButton.h
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一行放置几个item
 */
#define KRowCount 4
static float const kControllerHeaderViewHeight                = 90.f;
static float const kControllerHeaderToCollectionViewMargin    = 0;
static float const kCollectionViewCellsHorizonMargin          = 10;//cell的左右的距离
static float const kCollectionViewCellHeight                  = 30;
//static float const kCollectionViewItemButtonImageToTextMargin = 5;

/**
 *  cell四周的间距
 */
static float const kCollectionViewToLeftMargin                = 16;
static float const kCollectionViewToRightMargin               = 16;
static float const kCollectionViewToTopMargin                 = 0;
static float const kCollectionViewToBottomtMargin             = 10;

static float const kCellBtnCenterToBorderMargin               = 19;


@interface ItemButton : UIButton
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@end
