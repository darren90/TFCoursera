//
//  WaterCell.m
//  PUClient
//
//  Created by Fengtf on 15/8/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "WaterCell.h"
#import "MovieHome.h"
#import "SearchResultModel.h"

@interface WaterCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtTtleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImg;

@end

@implementation WaterCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setModel:(MovieHome *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:URL(model.cover) placeholderImage:placeholderImg];

    self.titleLabel.text = model.title;
    self.subtTtleLabel.text = [NSString stringWithFormat:@"更新至第%d集",model.upInfo];
    
    self.markImg.hidden = YES;
    self.markImg.image = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    if ([self.model.mark isEqualToString:@"hot"]) {
//        
//        UIImage * image = IMAGENAME(@"hot");
//        self.markImg.frame = CGRectMake(WIDTH(self) - image.size.width,0, image.size.width, image.size.height);
//        
//    }else if ([self.model.mark isEqualToString:@"fresh"]){
//        
//        UIImage * image = IMAGENAME(@"new_tv");
//        self.markImg.frame = CGRectMake(WIDTH(self) - image.size.width, 0, image.size.width, image.size.height);
//        
//    }else if ([self.model.mark isEqualToString:@"update"]){
//        
//        UIImage * image = IMAGENAME(@"new");
//        self.markImg.frame = CGRectMake(WIDTH(self) - image.size.width,0, image.size.width, image.size.height);
//    }
}

@end

