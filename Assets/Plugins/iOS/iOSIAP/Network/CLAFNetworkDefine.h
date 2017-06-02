//
//  CLAFNetworkDefine.h
//  TestDemo1231
//
//  Created by YuanRong on 16/1/4.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#ifndef CLAFNetworkDefine_h
#define CLAFNetworkDefine_h

/**
 *  请求类型
 */
typedef enum {
    cl_AFNetworkMethodGET = 1,
    cl_AFNetworkMethodPOST
} cl_AFNetworkMethod;



#if NS_BLOCKS_AVAILABLE
/**
 *  请求开始时的回调（下载时用到）
 */
typedef void (^cl_AFNStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^cl_AFNSuccessBlock)(id result);

/**
 *  请求失败后回调
 *
 *  @param error 回调block
 */
typedef void (^cl_AFNFailureBlock)(NSError *error);

#endif

#endif /* CLAFNetworkDefine_h */
