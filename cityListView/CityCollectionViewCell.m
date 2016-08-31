//
//  CityCollectionViewCell.m
//  Test
//
//  Created by 杨时雨 on 16/8/30.
//  Copyright © 2016年 xinzhangqu. All rights reserved.
//

#import "CityCollectionViewCell.h"
#define R_G_B(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation CityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //添加圆角
    self.cityButton.layer.cornerRadius = 3;
    self.cityButton.layer.masksToBounds = true;
    
    //添加变宽
    self.cityButton.layer.borderWidth = 1;
    self.cityButton.layer.borderColor = R_G_B(190 / 255,190 / 255, 190 / 255).CGColor;
}

@end
