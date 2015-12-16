//
//  WaterCell.h
//  PUClient
//
//  Created by Fengtf on 15/8/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieHome,SchedueModel,SearchResultModel;

@interface WaterCell : UICollectionViewCell

@property (nonatomic,strong)MovieHome * model;

/** 新增的用在排期表 */

@property (nonatomic,strong)SchedueModel * schedueModel;

@property (nonatomic,strong)SearchResultModel * searchModel;

@end
