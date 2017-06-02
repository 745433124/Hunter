



#import "IOSWechatPay.h"
#import "WXApi.h"

@implementation IOSWechatPay


#pragma mark - c

struct WechatPayConfig {
    char*  partnerId;
    char*  prepayId;
    char* nonceStr;
    int timeStamp;
    char* package;
    char* sign;
};

void __doWechatPay (struct WechatPayConfig *config){
    
    NSLog(@"nonceStr=%s",config->nonceStr);
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [NSString stringWithFormat:@"%s",config->partnerId];
    req.prepayId            = [NSString stringWithFormat:@"%s",config->prepayId];
    req.nonceStr            = [NSString stringWithFormat:@"%s",config->nonceStr];
    req.timeStamp           = config->timeStamp;
    req.package             = [NSString stringWithFormat:@"%s",config->package];
    req.sign                = [NSString stringWithFormat:@"%s",config->sign];
    [WXApi sendReq:req];
}

void _IOSBattery (){
    
    UIDevice *device =[UIDevice currentDevice];
    device.batteryMonitoringEnabled =YES;
    //UnitySendMessage("UnityReciveMsg", "SetBattery",[NSString stringWithFormat:@"%d",(int)(device.batteryLevel*100)].UTF8String);
}

void exitIosApp() {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:NO];
        window.bounds = CGRectZero;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

@end