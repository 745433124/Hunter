//
//  PurchaseController.m
//  MLIAPurchaseManager
//
//  Created by sunny.hong on 16/9/26.
//  Copyright © 2016年 mali. All rights reserved.
//


#import "PurchaseController.h"
#import "CommonCrypto/CommonDigest.h"
#import "MLIAPManager.h"

/*
 *购买操作  productId:产品ID
 */
extern "C" void purchase (char * productId , char * userid){
    
    NSString * productStr = [NSString stringWithFormat:@"%s",productId];
    NSString * useridStr = [NSString stringWithFormat:@"%s",userid];
    
    [MLIAPManager sharedManager].userId = useridStr;

    [[PurchaseController sharedManager] getServerceStatu:^(id result) {
        if (![result isKindOfClass:[NSError class]]) {
            [[MLIAPManager sharedManager] requestProductWithId:productStr];

        }
    }];
    
    
}


/*
 *本地缓存有receipt
 */
extern "C" void reSendReceipt (char * receipt , char * productid){
    
    NSString * receiptStr = [NSString stringWithFormat:@"%s",receipt];
    NSString * productStr = [NSString stringWithFormat:@"%s",productid];
    
    if ([receiptStr length] > 0) {
        [[MLIAPManager sharedManager] sendReceiptWithProductId:productStr andReceipt:receiptStr];
    }
    
    
    
}


/*
 *购买结果  0为成功
 */
extern "C" void purchaseResult (int purchaseResult){
    
    const char * result = [[NSString stringWithFormat:@"%d",purchaseResult] UTF8String];
    
    //UnitySendMessage("UnityReciveMsg", "OnApplePayResult", result);
}


/*
 *向服务器发送receipt失败
 */
extern "C" void receiptSendFail (const char * receipt){
    
    //UnitySendMessage("UnityReciveMsg", "OnApplePayResult", receipt);

}


@interface PurchaseController ()<MLIAPManagerDelegate,NSURLConnectionDataDelegate>

@end


@implementation PurchaseController{
    NSTimer * checkTimer;
    NSString * tradNumber;
}


+ (instancetype)sharedManager {
    
    static PurchaseController *iapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iapManager = [PurchaseController new];

    });
    
    return iapManager;
}


-(void) sendReceiptWithProductId:(NSString *)productId andReceipt:(NSString *)receipt{
    
    const char * receiptChar = [receipt UTF8String];
    
    receiptSendFail(receiptChar);
    
    
}

- (void)purchaseResultStatus:(int)result{
    NSLog(@"purchaseResultStatus%d",result);
    purchaseResult(result);
    
}


-(void) getServerceStatu:(cl_AFNSuccessBlock)block{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kUrl,@"Api/Pay/check"];
    
    [CLAFNetworkHandler clubRequestWithMethod:cl_AFNetworkMethodGET URL:urlString params:nil showHud:YES hudTitle:nil sucessBlock:^(id returnData) {
        NSLog(@"success:%@",returnData);
        block(returnData);
    } failureBlock:^(NSError *error) {
        NSLog(@"fail:%@",error);
    }];
}

@end
