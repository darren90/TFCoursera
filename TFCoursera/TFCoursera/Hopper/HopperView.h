//
//  HopperView.h
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HopperViewDelegate <NSObject>
@optional
-(void)HopperViewItemDidSelect:(NSString *)text;
@end

@interface HopperView : UIView


@property (nonatomic,weak)id<HopperViewDelegate> delegate;

/**
 *  选中的item
 */
@property (nonatomic, assign)NSInteger selectIndex;


@property (nonatomic,strong)NSArray * mainArray;

-(void)reloadView;
-(void)refreshHooper:(NSInteger)index;
@end
