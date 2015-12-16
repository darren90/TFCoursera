//
//  WaterCell.m
//  PUClient
//
//  Created by Fengtf on 15/8/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "WaterCell.h"
//#import "MovieHome.h"
#import "SchedueModel.h"
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
    //self.markImg.contentMode = UIViewContentModeScaleAspectFit;
    //self.markImg.frame = CGRectMake(WIDTH(self) - self.markImg.image.size.width,0, self.markImg.image.size.width, self.markImg.image.size.height);

    if ([model.mark isEqualToString:@"hot"]) {
        
        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"img_hot");
        self.markImg.image = image;
        
    }else if ([model.mark isEqualToString:@"fresh"]){
        
        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"new_tv");
        self.markImg.image = image;
        
    }else if ([model.mark isEqualToString:@"update"]){

        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"new");
        self.markImg.image = image;
    }

}

-(void)setSearchModel:(SearchResultModel *)searchModel
{
    _searchModel = searchModel;
    [self.imageView sd_setImageWithURL:URL(searchModel.cover) placeholderImage:placeholderImg];
    
    self.titleLabel.text = searchModel.title;
    self.subtTtleLabel.text = [NSString stringWithFormat:@"更新至第%@集",searchModel.upInfo];
    
    self.markImg.hidden = YES;
    self.markImg.image = nil;
    //self.markImg.contentMode = UIViewContentModeScaleAspectFit;
    //self.markImg.frame = CGRectMake(WIDTH(self) - self.markImg.image.size.width,0, self.markImg.image.size.width, self.markImg.image.size.height);
    
    if ([searchModel.mark isEqualToString:@"hot"]) {
        
        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"hot");
        self.markImg.image = image;
        
    }else if ([searchModel.mark isEqualToString:@"fresh"]){
        
        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"new_tv");
        self.markImg.image = image;
        
    }else if ([searchModel.mark isEqualToString:@"update"]){
        
        self.markImg.hidden = NO;
        UIImage * image = IMAGENAME(@"new");
        self.markImg.image = image;
    }

}

/** 新增的用在排期表 */
- (void)setSchedueModel:(SchedueModel *)schedueModel
{
    _schedueModel = schedueModel;
    [self.imageView sd_setImageWithURL:URL(schedueModel.coverUrl) placeholderImage:placeholderImg];
    
    self.titleLabel.text = schedueModel.seriesName;
    self.subtTtleLabel.text = schedueModel.episode ;
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

