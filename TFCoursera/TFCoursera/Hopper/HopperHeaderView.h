//
//  HopperHeaderView.h
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HopperHeaderViewDelegate <NSObject>
@optional
//-(void)HopperHeaderViewItemDidSelect:(NSString *)text dataArray:(NSArray *)dataArray;
-(void)HopperHeaderViewItemDidSelect:(NSString *)text index:(NSInteger)index;

@end

@interface HopperHeaderView : UICollectionReusableView
@property (nonatomic,weak)id<HopperHeaderViewDelegate> delegate;

@property (nonatomic,strong)NSArray * mainArray;

-(void)reloadView;
@end
