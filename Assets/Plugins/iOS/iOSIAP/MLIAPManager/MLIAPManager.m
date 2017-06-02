//
//  MLIAPManager.m
//  MLIAPurchaseManager
//
//  Created by mali on 16/5/14.
//  Copyright © 2016年 mali. All rights reserved.
//


#import "MLIAPManager.h"
#import "CLAFNetworkHandler.h"
#import "PurchaseController.h"


#import "CommonCrypto/CommonDigest.h"

@interface MLIAPManager() <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    SKProduct *myProduct;
    SKProductsRequest *productsRequest;
    
    NSTimer * checkTimer;
    NSString * tradNumber;
    
}

@end

@implementation MLIAPManager

#pragma mark - ****************  Singleton

+ (instancetype)sharedManager {
    
    static MLIAPManager *iapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iapManager = [MLIAPManager new];
    });
    
    return iapManager;
}

#pragma mark - ****************  Public Methods

/** TODO:请求商品*/
- (BOOL)requestProductWithId:(NSString *)productId {
    if (productId.length > 0) {
        NSLog(@"请求商品: %@", productId);
        productsRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productId]];
        productsRequest.delegate = self;
        [productsRequest start];
        return YES;
    } else {
        NSLog(@"商品ID为空");
    }
    return NO;
}

/** TODO:购买商品*/
- (BOOL)purchaseProduct:(SKProduct *)skProduct {
    
    if (skProduct != nil) {
        if ([SKPaymentQueue canMakePayments]) {
            SKPayment *payment = [SKPayment paymentWithProduct:skProduct];
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        } else {
            NSLog(@"失败，用户禁止应用内付费购买.");
        }
    }
    return NO;
}

/** TODO:非消耗品恢复*/
- (BOOL)restorePurchase {
    
    if ([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
        return YES;
    } else {
        NSLog(@"失败,用户禁止应用内付费购买.");
    }
    return NO;
}


#pragma mark - ****************  SKProductsRequest Delegate
- (void)requestDidFinish:(SKRequest *)request NS_AVAILABLE_IOS(3_0)
{
     NSLog(@"requestDidFinish");
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProductA = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %ld", (unsigned long)myProductA.count);
    // populate UI
    for(SKProduct *product in myProductA){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
        
    }
    
    NSArray *myProductArray = response.products;
    
    if (myProductArray.count > 0) {
        myProduct = [myProductArray objectAtIndex:0];
        [self receiveProduct:myProduct];
    } else {
        NSLog(@"无法获取产品信息，购买失败。");
        [self receiveProduct:myProduct];
    }
    
    
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"error , %@",error.localizedDescription);
}

#pragma mark - ****************  SKPaymentTransactionObserver Delegate

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"商品:%@被添加进购买列表",myProduct.localizedTitle);
                break;
            case SKPaymentTransactionStatePurchased://交易成功
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已购买过该商品
                break;
            case SKPaymentTransactionStateDeferred://交易延迟
                break;
            default:
                break;
        }
    }
}




- (void)receiveProduct:(SKProduct *)product {
    if (product != nil) {
        
        //购买商品
        if (![[MLIAPManager sharedManager] purchaseProduct:product]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您禁止了应用内购买权限,请到设置中开启" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:@"无法连接App store!" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)successfulPurchaseOfId:(NSString *)productId andReceipt:(NSData *)transactionReceipt {
    NSLog(@"购买成功%@",transactionReceipt);
    
    NSString  *transactionReceiptString = [transactionReceipt base64EncodedStringWithOptions:0];
    
    if ([transactionReceiptString length] > 0) {
        [self sendReceiptWithProductId:productId andReceipt:transactionReceiptString];
        // 向自己的服务器验证购买凭证（此处应该考虑将凭证本地保存,对服务器有失败重发机制）
        /**
         服务器要做的事情:
         接收ios端发过来的购买凭证。
         判断凭证是否已经存在或验证过，然后存储该凭证。
         将该凭证发送到苹果的服务器验证，并将验证结果返回给客户端。
         如果需要，修改用户相应的会员权限
         */
    }
}

- (void)failedPurchaseWithError:(NSString *)errorDescripiton {
    NSLog(@"购买失败");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:errorDescripiton delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}



#pragma mark - request

-(void) sendReceiptWithProductId:(NSString *)productId andReceipt:(NSString *)receipt{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kUrl,@"Api/Pay/validateReceipt"];
    
    NSString * timeStr = [NSString stringWithFormat:@"%.f",(double)[[NSDate date] timeIntervalSince1970]];
    
    
    NSString * signStr = [self md5Encrypt:[NSString stringWithFormat:@"%@%@%@%@%@",self.userId,productId,receipt,timeStr,kSignCode]];
    
    NSLog(@"timeStr:%@------sign:%@",timeStr,signStr);
    
    
    NSDictionary * dic = @{
                           @"productId": productId,
                           @"uname": self.userId,
                           @"sign": signStr,
                           @"receipt": receipt,
                           @"timestamp":@(timeStr.doubleValue)
                           };
    [CLAFNetworkHandler clubRequestWithMethod:cl_AFNetworkMethodPOST URL:urlString params:dic showHud:YES hudTitle:nil sucessBlock:^(id returnData) {
        if ([returnData[@"result"] intValue] == 200) {
            
            tradNumber = returnData[@"data"][@"tradeNo"]==nil?@"":returnData[@"data"][@"tradeNo"];
            
            checkTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(checkIdentifier) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:checkTimer forMode:NSDefaultRunLoopMode];

            [checkTimer fire];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"服务器错误" message:[NSString stringWithFormat:@"errorCode:%@\nresult:%@",returnData[@"errorCode"],returnData[@"result"]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        NSLog(@"success:%@",returnData);
        
    } failureBlock:^(NSError *error) {
        //发送receipt失败
        [[PurchaseController sharedManager]sendReceiptWithProductId:productId andReceipt:receipt];
        NSLog(@"fail:%@",error);
    }];
}


-(void) checkIdentifier{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",kUrl,@"Api/Pay/checkReceiptResult"];
    
    
    NSString * timeStr = [NSString stringWithFormat:@"%.f",(double)[[NSDate date] timeIntervalSince1970]];
    
    NSString * tradNo = tradNumber;
    
    NSString * signStr = [self md5Encrypt:[NSString stringWithFormat:@"%@%@%@",tradNo,timeStr,kSignCode]];
    
    NSLog(@"timeStr:%@------sign:%@",timeStr,signStr);
    
    
    NSDictionary * dic = @{
                           @"tradeNo": tradNo,
                           @"sign": signStr,
                           @"timestamp":@(timeStr.doubleValue)
                           };
    [CLAFNetworkHandler clubRequestWithMethod:cl_AFNetworkMethodPOST URL:urlString params:dic showHud:YES hudTitle:nil sucessBlock:^(id returnData) {
        NSLog(@"success:%@",returnData);
        if ([returnData[@"result"] intValue] == 200) {
            if ([returnData[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([returnData[@"data"][@"status"]intValue] != 0) {
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:returnData[@"data"][@"status"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    [checkTimer invalidate];
                    checkTimer = nil;
                }
                
                [[PurchaseController sharedManager]purchaseResultStatus:[returnData[@"data"][@"status"]intValue]];
                
            }else if([returnData[@"result"] intValue] == 0){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"服务器正在验证..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"服务器报错" message:[NSString stringWithFormat:@"errorCode:%@\nresult:%@",returnData[@"errorCode"],returnData[@"result"]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"fail:%@",error);
    }];
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


- (NSString *)md5Encrypt:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




#pragma mark - ****************  Private Methods

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    [self successfulPurchaseOfId:transaction.payment.productIdentifier andReceipt:receiptData];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled && transaction.error.code != SKErrorUnknown) {
        [self failedPurchaseWithError:transaction.error.localizedDescription];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

@end
