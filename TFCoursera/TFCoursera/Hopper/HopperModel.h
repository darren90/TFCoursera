//
//  HopperModel.h
//  PUClient
//
//  Created by Fengtf on 15/12/3.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HopperModel : NSObject

@property (nonatomic,copy)NSString * title;

@property (nonatomic,assign)BOOL isSelect;


-(instancetype)iniWithTitle:(NSString *)title isSelect:(BOOL)isSelect;
+(instancetype)hopperWithTitle:(NSString *)title isSelect:(BOOL)isSelect;

@end
