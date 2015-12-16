//
//  HopperModel.m
//  PUClient
//
//  Created by Fengtf on 15/12/3.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import "HopperModel.h"

@implementation HopperModel
-(instancetype)iniWithTitle:(NSString *)title isSelect:(BOOL)isSelect
{
    if (self == [super init]) {
        self.title = title;
        self.isSelect = isSelect;
    }
    return self;
}
+(instancetype)hopperWithTitle:(NSString *)title isSelect:(BOOL)isSelect
{
    return [[self alloc]iniWithTitle:title isSelect:isSelect];
}

@end
