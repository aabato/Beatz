//
//  MAAudioTrack.h
//  MoodAlarm
//
//  Created by Angelica Bato on 6/4/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAAudioTrack : NSObject


@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *artists;
@property (assign, nonatomic) CGFloat acousticness;
@property (assign, nonatomic) CGFloat danceability;
@property (assign, nonatomic) CGFloat valence;


- (instancetype)init;
- (instancetype)initWithID:(NSString *)identifier
                      name:(NSString *)name
                   artists:(NSArray *)artists;
- (NSString *)description;

@end
