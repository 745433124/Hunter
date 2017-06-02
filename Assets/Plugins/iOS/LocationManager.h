//
//  LocationManager.h
//  Unity-iPhone
//
//  Created by hongbo on 16/6/6.
//
//

#import <Foundation/Foundation.h>

//#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>



@interface LocationManager : NSObject <BMKLocationServiceDelegate>

@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,strong) NSString *locationStr;//定位返回dizhi
@property (nonatomic,assign) CLLocationDegrees latitude;
@property (nonatomic,assign) CLLocationDegrees longitude;


+ (LocationManager*)sharedInstance;

-(NSString *)getLocationInfo;  //返回定位信息

//返回定位字典
//- (NSDictionary *)getLocationInfoDic;

-(void)startLocation;

@end
