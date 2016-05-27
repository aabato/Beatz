//
//  MALocationServices.h
//  MoodAlarm
//
//  Created by Angelica Bato on 5/26/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface MALocationStore : NSObject <CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;

+ (instancetype)sharedStore;
- (void)getLocation;
-(NSArray *)getCurrentLocationInformation;
- (void)getWeatherWithCompletionBlock:(void(^)(BOOL))completionBlock;


@end
