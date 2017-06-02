#import <Foundation/Foundation.h>

@interface IOSWechatPay : NSObject

#ifdef __cplusplus
extern "C" {
#endif
    
    void __doWechatPay(struct WechatPayConfig *config);
    
    void _IOSBattery();
	
	 void exitIosApp();
    
#ifdef __cplusplus
}
#endif


@end