//
//  MAWeatherAPI.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "MAWeatherAPIClient.h"
@import CoreLocation;

@implementation MAWeatherAPIClient

+ (void)getWeatherInfoForCurrentLocationForLatitude:(NSString *)latitude longitude:(NSString *)longitude withCompletion:(void (^)(NSDictionary *))completionBlock {
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@,%@",darkSkyForecastURL,DarkSkyForecastAPIKey,latitude,longitude];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            NSLog(@"SUCCESS!");
//            NSLog(@"%@",responseObject);
            completionBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"SOMETHING WENT WRONG");
            NSLog(@"%@",error);
        }];
    
    
}






@end
