//
//  LocationCityVC.h
//  cityListView
//
//  Created by 杨时雨 on 16/8/30.
//  Copyright © 2016年 cps. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocationCityVCDelegate <NSObject>
@optional
-(void)backCityName:(NSString *)cityName;

@end
@interface LocationCityVC : UIViewController

@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) NSString *getCityName;

typedef void(^cityName)(NSString *);

@property (nonatomic, copy) cityName city;
@property(nonatomic,weak)id<LocationCityVCDelegate>delegate;
@end
