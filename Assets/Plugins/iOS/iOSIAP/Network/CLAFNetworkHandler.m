//
//  CLAFNetworkHandler.m
//  TestDemo1231
//
//  Created by YuanRong on 16/1/4.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#import "CLAFNetworkHandler.h"
#import "AFNetworking.h"


#define cl_CustomErrorDomain @"com.qunl.qunlele.error"
#define cl_APITimeOut 10



typedef NS_ENUM(NSInteger, CustomErrorFailedType) {
    CustomErrorFailedTypeNotReachable = -2000,
    CustomErrorFailedTypeStatusError = -2001,
};



@interface CLAFNetworkHandler ()

@property (nonatomic, assign) BOOL networkError;
@property (nonatomic, copy) NSString * authString;

@end

@implementation CLAFNetworkHandler

#pragma mark - Init

+ (CLAFNetworkHandler *)shareInstance {
    static CLAFNetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[CLAFNetworkHandler alloc] init];
        [self startMonitoring];
    });
    return handler;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.networkError = NO;
        self.authString = @"Basic MzAwMDAwMDMwMDA6QlA5SzQ2elE=";
    }
    return self;
}


+ (void)setAuth:(NSString *) auth
{
    [CLAFNetworkHandler shareInstance].authString = auth;
}


+ (NSURLCache *)defaultURLCache {
    return [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                         diskCapacity:32 * 1024 * 1024
                                             diskPath:@"com.qunl.qunlele.URLCache"];
}

+ (NSURLSessionConfiguration *)defaultURLSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //TODO set the default HTTP headers
    
    configuration.HTTPShouldSetCookies = YES;
    configuration.HTTPShouldUsePipelining = NO;
    
    configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    configuration.allowsCellularAccess = YES;
    configuration.timeoutIntervalForRequest = cl_APITimeOut;
    configuration.URLCache = [CLAFNetworkHandler defaultURLCache];
    
    return configuration;
}

#pragma mark - Public Method

+ (void)requestWithMethod:(cl_AFNetworkMethod)method
                      URL:(NSString *)url
                   params:(NSDictionary *)params
                  showHud:(BOOL)showHud
                 hudTitle:(NSString *)title
              sucessBlock:(cl_AFNSuccessBlock)successBlock
             failureBlock:(cl_AFNFailureBlock)failureBlock
{
    NSLog(@"requestWithMethod url %@",url);
    [CLAFNetworkHandler requestWithMethod:method URL:url params:params showHud:showHud hudTitle:title sucessBlock:successBlock failureBlock:failureBlock withHead:NO];
}

//////俱乐部的请求
+ (void) clubRequestWithMethod:(cl_AFNetworkMethod)method
                           URL:(NSString *)url
                        params:(NSDictionary *)params
                       showHud:(BOOL)showHud
                      hudTitle:(NSString *)title
                   sucessBlock:(cl_AFNSuccessBlock)successBlock
                  failureBlock:(cl_AFNFailureBlock)failureBlock
{

    NSLog(@"clubRequestWithMethod url  method %d,  %@",method,url);
    [CLAFNetworkHandler requestWithMethod:method URL:url params:params showHud:showHud hudTitle:title sucessBlock:successBlock failureBlock:failureBlock withHead:YES];

}





+ (void)requestWithMethod:(cl_AFNetworkMethod)method
                      URL:(NSString *)url
                   params:(NSDictionary *)params
                  showHud:(BOOL)showHud
                 hudTitle:(NSString *)title
              sucessBlock:(cl_AFNSuccessBlock)successBlock
             failureBlock:(cl_AFNFailureBlock)failureBlock
                 withHead:(BOOL) head  {
    
    
    
    if ([CLAFNetworkHandler shareInstance].networkError == YES) {
        
        
        if (failureBlock) {
            NSError *notReachableError = [[NSError alloc] initWithDomain:cl_CustomErrorDomain
                                                                    code:CustomErrorFailedTypeNotReachable
                                                                userInfo:nil];
            failureBlock(notReachableError);
        }
    } else {
        
        if (showHud) {
            
            
        }
        
        if (method == cl_AFNetworkMethodGET) {
            [self fml_getWithURL:url
                          params:params
                         showHud:showHud
                        hudTitle:title
                     sucessBlock:successBlock
                    failureBlock:failureBlock
                        withHead:head];
        }
        else if (method == cl_AFNetworkMethodPOST) {
            [self fml_postWithURL:url
                           params:params
                          showHud:showHud
                         hudTitle:title
                      sucessBlock:successBlock
                     failureBlock:failureBlock
                         withHead:head];
        }
    }
}

+ (void)fml_postWithURL:(NSString *)url
                 params:(NSDictionary *)params
                showHud:(BOOL)showHud
               hudTitle:(NSString *)title
            sucessBlock:(cl_AFNSuccessBlock)successBlock
           failureBlock:(cl_AFNFailureBlock)failureBlock
               withHead:(BOOL) head{
    
    NSURLSessionConfiguration *defaultConfiguration = [CLAFNetworkHandler defaultURLSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:defaultConfiguration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",nil];
    
    
    if (head) {
        NSLog(@"%@",[CLAFNetworkHandler shareInstance].authString);
        [manager.requestSerializer setValue:[CLAFNetworkHandler shareInstance].authString forHTTPHeaderField:@"Authorization"];//设置请求头
    }
    
    [manager POST:url
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
              
              NSLog(@" \n ######--->>>Request URL String<<<---###### %@ %@ \n ######--->>>Response<<<---###### %@ ", task.currentRequest.URL, params, responseObject);
              
              if (successBlock) {
                  successBlock(responseObject);
              }
              
              
                  
                  if (failureBlock) {
                      NSError *notReachableError = [[NSError alloc] initWithDomain:cl_CustomErrorDomain
                                                                              code:CustomErrorFailedTypeStatusError
                                                                          userInfo:nil];
                      failureBlock(notReachableError);
                  }
              
          } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              
              NSLog(@" \n ######--->>>Request URL String<<<---###### %@ %@ \n ######--->>>Error<<<---###### %@ ", task.currentRequest.URL, params, error.description);
              
              if (failureBlock) {
                  failureBlock(error);
              }
              
              if (showHud) {
                  
//                  [CLProgressHUD showErrorWithtitle:LCAlterNetworkTimeout
//                                           duration:kDismissCommonDuration];
                  
              }
          }];
}

+ (void)fml_getWithURL:(NSString *)url
                params:(NSDictionary *)params
               showHud:(BOOL)showHud
              hudTitle:(NSString *)title
           sucessBlock:(cl_AFNSuccessBlock)successBlock
          failureBlock:(cl_AFNFailureBlock)failureBlock
              withHead:(BOOL) head{
    
    NSURLSessionConfiguration *defaultConfiguration = [CLAFNetworkHandler defaultURLSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:defaultConfiguration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",nil];
    
    
    if (head) {
        [manager.requestSerializer setValue:[CLAFNetworkHandler shareInstance].authString forHTTPHeaderField:@"Authorization"];//设置请求头
    }
    

    
    [manager GET:url
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
             
             NSLog(@" \n ######--->>>Request URL String<<<---###### %@ %@ \n ######--->>>Response<<<---###### %@ ", task.currentRequest.URL, params, responseObject);
             
             
             
           
                 
                 if (successBlock) {
                     successBlock(responseObject);
                 }
                 
             
                 if (failureBlock) {
                     NSError *notReachableError = [[NSError alloc] initWithDomain:cl_CustomErrorDomain
                                                                             code:CustomErrorFailedTypeStatusError
                                                                         userInfo:nil];
                     failureBlock(notReachableError);
                 }
                 
             
         } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
             
             NSLog(@" \n ######--->>>Request URL String<<<---###### %@ %@ \n ######--->>>Error<<<---###### %@ ", task.currentRequest.URL, params, error.description);
             
             if (failureBlock) {
                 failureBlock(error);
             }
             
             if (showHud) {
                 
//                 [CLProgressHUD showErrorWithtitle:LCAlterNetworkTimeout
//                                          duration:kDismissCommonDuration];
                 
             }
         }];
}

+ (void)startMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [CLAFNetworkHandler shareInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [CLAFNetworkHandler shareInstance].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [CLAFNetworkHandler shareInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [CLAFNetworkHandler shareInstance].networkError = NO;
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
