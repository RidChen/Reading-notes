//
//  MapViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/4/6.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface MapViewController ()
{
    BMKMapManager* _mapManager;
    BMKMapView* _mapView;
    BMKLocationService* _locService;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:MAP_BAIDU_PRIVATE_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(UI_MSG_UNPAYED_X,
                                                           UI_MSG_UNPAYED_Y,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height - UI_MSG_UNPAYED_Y)];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel = 16.0f;
    self.view = _mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    [_locService stopUserLocationService];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
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
