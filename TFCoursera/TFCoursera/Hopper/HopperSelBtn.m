//
//  hopperSelBtn.m
//  PUClient
//
//  Created by Fengtf on 15/12/2.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import "HopperSelBtn.h"

@implementation HopperSelBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"hopper_ic_down"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeRight;
        
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    }
    return self;
}

//-(void)setHighlighted:(BOOL)highlighted
//{
//
//}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * 0.5, contentRect.size.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.5, 0, contentRect.size.width * 0.5, contentRect.size.height);
}



-(void)setSelectTitle:(NSString *)selectTitle
{
    _selectTitle = [selectTitle copy];
    
    [self setTitle:selectTitle forState:UIControlStateNormal];
    [self setTitle:selectTitle forState:UIControlStateHighlighted];
}

@end
