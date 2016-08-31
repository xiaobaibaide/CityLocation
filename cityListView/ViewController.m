//
//  ViewController.m
//  cityListView
//
//  Created by 杨时雨 on 16/8/30.
//  Copyright © 2016年 cps. All rights reserved.
//

#import "ViewController.h"
#import "CityTableViewCell.h"
#import "NSString+hkString.h"

#import "LocationCityVC.h"
//屏幕尺寸
#define HScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define HScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define R_G_B(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface ViewController ()<LocationCityVCDelegate>
/**
 *  sectionArray 存区array
 *  cityArray    存城市的数组
 */

@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *sectionNameArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)testPresent:(id)sender {
    
    LocationCityVC * locatin = [[LocationCityVC alloc]init];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:locatin];
    locatin.city=^(NSString *cityname){
        [self.cityName setTitle:cityname forState:UIControlStateNormal];
    };
    locatin.delegate=self;
    [self presentViewController:nv animated:YES completion:^{
        NSLog(@"开始定位");
    }];
    
}
//城市名字回调
-(void)backCityName:(NSString *)cityName
{
    [self.cityName setTitle:cityName forState:UIControlStateNormal];
}
@end
