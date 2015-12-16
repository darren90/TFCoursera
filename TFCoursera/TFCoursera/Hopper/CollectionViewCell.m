//
//  CollectionViewCell.m
//  CollectionViewClassifyMenu
//
//  Created by https://github.com/ChenYilong on 15/3/17.
//  Copyright (c)  http://weibo.com/luohanchenyilong/ . All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIButton+CollectionCellStyle.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup {
    self.button = [ItemButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.contentView addSubview:self.button];
//    [self.button generalStyle];
//    [self.button homeStyle];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitle:title forState:UIControlStateSelected];
//    self.button.section = self.section;
//    self.button.row = self.row;
}

@end
