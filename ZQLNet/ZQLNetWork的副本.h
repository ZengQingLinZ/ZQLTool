//
//  ZQLNetWork.h
//  ZQL_LOL
//
//  Created by teacher on 16-12-26.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

@interface ZQLNetWork : NSObject
//get请求
+(void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure ;

//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure ;

//delete请求
+(void)deleteWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure;

/**
 *上传图片(单张)
 */
+(void)uploadPhotoAndController:(UIViewController *)controller WithSize:(CGSize)size Image:(UIImage*)image urlString:(NSString *)urlString parameters:(NSDictionary *)param imageKey:(NSString *)imageKey success:(HttpSuccess)success failure:(HttpFailure)failure;

/**
 *上传多张图片
 */
+ (void)upImagesWithArray :(NSArray *)imageArr :(UIViewController *)controller urlString:(NSString *)urlString parameters:(NSDictionary *)param imageKey:(NSString *)imageKey success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
