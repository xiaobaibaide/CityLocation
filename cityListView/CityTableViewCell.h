//
//  CityTableViewCell.h
//  Test
//
//  Created by 杨时雨 on 16/8/30.
//  Copyright © 2016年 xinzhangqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell

typedef void(^cityName)(NSString *);

@property (nonatomic, copy) cityName city;

@property (nonatomic, strong) NSArray *cityArray;

@property (weak, nonatomic) IBOutlet UICollectionView *cityCollectionView;


@end
