//
//  PurchaseController.h
//  MLIAPurchaseManager
//
//  Created by sunny.hong on 16/9/26.
//  Copyright © 2016年 mali. All rights reserved.
//

#define kUrl @"https://hk.qunl.com:92/"
#define kSignCode @"qunle2016ShenZhen"

#import <Foundation/Foundation.h>
#import "CLAFNetworkHandler.h"
#import "MLIAPManager.h"


@interface PurchaseController : NSObject

@property (nonatomic,assign) int purchaseStatus;
@property (nonatomic,copy) NSString * userId;

+ (instancetype)sharedManager;

-(void) getServerceStatu:(cl_AFNSuccessBlock)block;
-(void) sendReceiptWithProductId:(NSString *)productId andReceipt:(NSString *)receipt;
- (void)purchaseResultStatus:(int)result;

@end
