//
//  MAWeatherAPI.h
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "Secrets.h"

@interface MAWeatherAPI : NSObject

+ (void)getWeatherInfoForCurrentLocationForLatitude:(NSString *)latitude longitude:(NSString *)longitude withCompletion:(void (^)(NSDictionary *))completionBlock;
@end
