//
//  ZQLNetWork.m
//  ZQL_LOL
//
//  Created by teacher on 16-12-26.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "ZQLNetWork.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZQLNetWork


//GET请求
+(void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure {
    NSLog(@"GET参数:%@ URL:%@",parameters,urlString);
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [manager.requestSerializer setValue:sessionid forHTTPHeaderField:@"authorization"];
    
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    //get请求
    
    [manager GET:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *netDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments|NSJSONReadingMutableLeaves error:nil];
        success(netDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
}

//POST请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure {
    NSLog(@"请求URL:%@ POST参数:%@",urlString,parameters);
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 20;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (sessionid.length>0) {
        //设置请求头
        [manager.requestSerializer setValue:sessionid forHTTPHeaderField:@"authorization"];
    }
    
    
    //内容类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //post请求
    [manager POST:urlString parameters:parameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *netDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments|NSJSONReadingMutableLeaves error:nil];

        success(netDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

//DELETE请求
+(void)deleteWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters sessionid:(NSString *)sessionid success:(HttpSuccess)success failure:(HttpFailure)failure {
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [manager.requestSerializer setValue:sessionid forHTTPHeaderField:@"authorization"];
    
    [manager DELETE:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功的操作
        if (success) {
            NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
            if(dict){
                success(dict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
}

//上传图片(单张)
+(void)uploadPhotoAndController:(UIViewController *)controller WithSize:(CGSize)size Image:(UIImage*)image urlString:(NSString *)urlString parameters:(NSDictionary *)param imageKey:(NSString *)imageKey success:(HttpSuccess)success failure:(HttpFailure)failure
{

    //1. 存放图片的服务器地址，这里我用的宏定义
    //    NSString * url = [NSString stringWithFormat:@"%@%@",Hx_Main_heard_API,IMAGE_UPLOAD_URL_API];
    //UIImage *newimg=[UIImage thumbnailWithImageWithoutScale:image size:size];
    
    //2. 利用时间戳当做图片名字
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    
    //3. 图片二进制文件
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7f);
    NSLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
    
    //4. 发起网络请求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求头
    //    [manager.requestSerializer setValue:sessionid forHTTPHeaderField:@"authorization"];
    //内容类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageKey) {
            // 上传图片，以文件流的格式，这里注意：name是指服务器端的文件夹名字
            [formData appendPartWithFileData:imageData name:imageKey fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功时的回调
    
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败时的回调
        failure(error);
     
    }];
}

//传图片流
+ (void)upImagesWithArray :(NSArray *)imageArr :(UIViewController *)controller urlString:(NSString *)urlString parameters:(NSDictionary *)param imageKey:(NSString *)imageKey success:(HttpSuccess)success failure:(HttpFailure)failure{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        // 上传 多张图片
        for(NSInteger i = 0; i < imageArr.count; i++) {
            NSData * imageData = UIImageJPEGRepresentation([imageArr objectAtIndex: i], 0.5);
            // 上传的参数名
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:@"UploadForms[picture][]" fileName:fileName mimeType:@"image/jpeg"];
        }
        
        //        // 上传图片，以文件流的格式，这里注意：name是指服务器端的文件夹名字
        //        [formData appendPartWithFileData:imageData name:@"UploadForm[portrait]" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功时的回调
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败时的回调
        failure(error);
    }];
    
}

@end
