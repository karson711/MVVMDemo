//
//  MVVMCell.m
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "MVVMCell.h"

@interface MVVMCell()

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsSource;
@property (weak, nonatomic) IBOutlet UILabel *newsTypeName;

@end

@implementation MVVMCell
//@synthesize cellModel;

-(void)setCellModel:(MVVMCellModel *)cellModel{
    _cellModel = cellModel;
    self.newsTitle.text = cellModel.newsTitle;
    self.newsSource.text = cellModel.newsSource;
    self.newsTypeName.text = cellModel.newsTypeName;
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:cellModel.newsImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
