//
//  CLAFNetworkHandler.h
//  TestDemo1231
//
//  Created by YuanRong on 16/1/4.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLAFNetworkDefine.h"


/**
 *  网络请求Handler类
 */
@interface CLAFNetworkHandler : NSObject


//////设置鉴权
+ (void)setAuth:(NSString *) auth;


//////非俱乐部的请求
/*
  服务器返回数据 successBlock
  服务器没回应或者超时 failureBlock
 */
+ (void)requestWithMethod:(cl_AFNetworkMethod)method
                      URL:(NSString *)url
                   params:(NSDictionary *)params
                  showHud:(BOOL)showHud
                 hudTitle:(NSString *)title
              sucessBlock:(cl_AFNSuccessBlock)successBlock
             failureBlock:(cl_AFNFailureBlock)failureBlock;



//////俱乐部的请求
/*
 服务器返回数据 successBlock
 服务器没回应或者超时 failureBlock
 */
+ (void) clubRequestWithMethod:(cl_AFNetworkMethod)method
                      URL:(NSString *)url
                   params:(NSDictionary *)params
                  showHud:(BOOL)showHud
                 hudTitle:(NSString *)title
              sucessBlock:(cl_AFNSuccessBlock)successBlock
             failureBlock:(cl_AFNFailureBlock)failureBlock;





@end
