//
//  NSURL+FragmentString.h
//  MoodAlarm
//
//  Created by Angelica Bato on 5/27/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryString)

-(NSString *)valueForFirstFragmentItemNamed:(NSString *)name;

-(NSString *)valueForFirstQueryItemNamed:(NSString *)name;

@end
