//
//  CityTableViewCell.m
//  Test
//
//  Created by 杨时雨on 16/8/30.
//  Copyright © 2016年 xinzhangqu. All rights reserved.
//

#import "CityTableViewCell.h"
#import "CityCollectionViewCell.h"
//屏幕尺寸
#define HScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define HScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define R_G_B(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface CityTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CityTableViewCell

static NSString *const collectionIdentifer =@"CityCollectionViewCell";

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self.cityCollectionView setBackgroundColor:R_G_B(240, 240, 240)];
    [self.cityCollectionView registerNib:[UINib nibWithNibName:collectionIdentifer bundle:nil] forCellWithReuseIdentifier:collectionIdentifer];
}

- (void)setCityArray:(NSArray *)cityArray
{
    if (_cityArray != cityArray) {
        _cityArray =cityArray;
        [self.cityCollectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cityArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifer forIndexPath:indexPath];
    //[cell setBackgroundColor:rgb(240, 240, 240)];
    [cell.cityButton setTitle:self.cityArray[indexPath.row] forState:UIControlStateNormal];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(HScreenWidth / 4 - 20,40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.city(self.cityArray[indexPath.row]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
