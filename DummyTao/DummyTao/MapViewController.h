//
//  MapViewController.h
//  DummyTao
//
//  Created by 陈宇 on 2017/4/6.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface MapViewController : UIViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>

@end
