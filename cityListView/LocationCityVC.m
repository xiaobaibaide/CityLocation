//
//  LocationCityVC.m
//  cityListView
//
//  Created by 杨时雨 on 16/8/30.
//  Copyright © 2016年 cps. All rights reserved.
//

#import "LocationCityVC.h"
#import "CityTableViewCell.h"
#import "NSString+hkString.h"
#import <CoreLocation/CoreLocation.h>

//屏幕尺寸
#define HScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define HScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define R_G_B(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface LocationCityVC ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
/**
 *  sectionArray 存区array
 *  cityArray    存城市的数组
 */

@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *sectionNameArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionView;


/*定位
 */
@property(strong, nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic)NSString *currentCity;
@end

@implementation LocationCityVC
static NSString *const cityCellIdentifer =@"CityTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"城市选择";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:cityCellIdentifer];
    
    
    self.currentCity = [[NSString alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        NSString *title = NSLocalizedString(@"无法进行定位", nil);
        NSString *message = NSLocalizedString(@"请检查您的设备是否开启定位功能", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"确定。。。。");
        }];
        [alertController addAction:otherAction];
    }
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    __weak typeof (self)weakSelf =self;
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0)
        {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            weakSelf.getCityName=self.currentCity;
            // ? placeMark.locality : placeMark.administrativeArea;
            if (!self.currentCity) {
                self.currentCity = NSLocalizedString(@"无法定位当前城市",nil);
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            });
        });
            
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            NSLog(@"Location error: %@, error");
        }
    }];
    
    [manager stopUpdatingLocation];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArray.count+2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    return [[self.cityArray objectAtIndex:section-2] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        CityTableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifer forIndexPath:indexPath];
        if (_getCityName!=nil)
        {
            cityCell.cityArray=@[_getCityName];
        }
        else
        {
            cityCell.cityArray=@[@"定位中."];
        }
        __weak typeof (self)weakSelf =self;
        cityCell.city = ^(NSString *cityName){
            if (_getCityName != nil) {
                weakSelf.city(_getCityName);
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                weakSelf.city(cityName);
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        };
        return cityCell;
        return cityCell;
    }
    if (indexPath.section == 1) {
        CityTableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifer forIndexPath:indexPath];
        
        cityCell.cityArray = @[@"温州市",@"杭州市", @"上海市", @"深圳市",@"北京市",@"南京市",@"广州市",@"武汉市"];
        
        __weak typeof (self)weakSelf =self;
        cityCell.city = ^(NSString *cityName){
            weakSelf.city(cityName);
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        };
        return cityCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section != 0 && indexPath.section != 1)
        cell.textLabel.text = self.cityArray[indexPath.section-2][indexPath.row];
    else
        cell.textLabel.text = @"";
    return cell;
}
#pragma mark - UITableViewDelegate
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionArray;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 50;
    else if(indexPath.section == 1)
        return 100;
    
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect sectionViewframe = CGRectMake(0, 0, HScreenWidth, 44);
    CGRect sectionLabelFrame = CGRectMake(10, 5, HScreenHeight/2, 34);
    
    UIView *sectionView = [[UIView alloc] init];
    sectionView.frame = sectionViewframe;
    sectionView.backgroundColor = R_G_B(246, 246, 246);
    
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.font = [UIFont systemFontOfSize:14];
    sectionLabel.frame = sectionLabelFrame;
    sectionLabel.textColor = R_G_B(176, 176, 176);
    sectionLabel.text = self.sectionNameArray[section];
    [sectionView addSubview:sectionLabel];
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section != 0 && indexPath.section != 1)
//            [self.delegate backCityName: self.city(self.cityArray[indexPath.section-2][indexPath.row])];
    if (indexPath.section != 0 && indexPath.section != 1)
    {
        if ([self.delegate respondsToSelector:@selector(backCityName:)]) {
            [self.delegate backCityName:self.cityArray[indexPath.section-2][indexPath.row]];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

/* 以下为懒加载 */
#pragma mark - 懒加载

- (NSMutableArray *)sectionArray
{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray arrayWithObjects:@"当",@"热", nil];
    }
    return _sectionArray;
}

- (NSMutableArray *)sectionNameArray
{
    if (!_sectionNameArray) {
        _sectionNameArray = [NSMutableArray arrayWithObjects:@"当前城市",@"热门城市", nil];
    }
    return _sectionNameArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        
        _cityArray = [NSMutableArray new];
        
        NSString *pathString =[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:pathString];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSArray class]]) {
                NSArray *cityArr =obj;
                NSString *string = [[NSString transform:cityArr.firstObject] substringToIndex:1];
                [self.sectionArray addObject:string];
                [self.sectionNameArray addObject:string];
                [_cityArray addObject:cityArr];
            }
        }];
    }
    return _cityArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        CGRect tableViewRect = self.view.bounds;
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = tableViewRect;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = [UIColor blackColor];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
