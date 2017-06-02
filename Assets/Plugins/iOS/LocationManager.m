//
//  LocationManager.m
//  Unity-iPhone
//
//  Created by hongbo on 16/6/6.
//
//

#import "LocationManager.h"



@interface LocationManager()
{
    //    NSDictionary *_locationDic;
    BMKLocationService* _locService;
    
}

@end

@implementation LocationManager


+ (LocationManager*)sharedInstance
{
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype) init
{
    self = [super init];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotify:) name:kNotificationNameLogin object:nil];
    
    return self;
}





-(void)startLocation{
    
    if(!_locService)
    {
        self.geocoder = [[CLGeocoder alloc] init];
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
}



-(NSString *)getLocationInfo{
    
    return self.locationStr;
    
}



/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"%lf.......%lf",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    CLLocation *curLocation = userLocation.location;
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSDictionary *dic = placemark.addressDictionary;

        if (placemark.name) {
            
            self.locationStr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"City"] ];
        
        }else{
            
            
        }
        
        self.latitude = curLocation.coordinate.latitude;
        self.longitude = curLocation.coordinate.longitude;
        [_locService stopUserLocationService];
        //经纬度上传打服务器
        NSString *tempStr = [NSString stringWithFormat:@"%f|%f|%@",self.longitude,self.latitude,self.locationStr];
        UnitySendMessage("UnityReciveMsg", "SetMyLocation", [tempStr UTF8String]);
        
    }];

}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    
}


@end
