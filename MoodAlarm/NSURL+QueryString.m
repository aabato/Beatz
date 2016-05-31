//
//  NSURL+FragmentString.m
//  MoodAlarm
//
//  Created by Angelica Bato on 5/27/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "NSURL+QueryString.h"

@implementation NSURL (QueryString)

-(NSString *)valueForFirstFragmentItemNamed:(NSString *)name
{
    NSURLComponents *urlComps = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:nil];
    NSString *fragmentItem = urlComps.fragment;
    NSArray *queryItems = [fragmentItem componentsSeparatedByString:@"&"];
    NSMutableDictionary *queryItemsDict = [NSMutableDictionary new];
    for (NSString *queryItem in queryItems) {
        NSArray *splitString = [queryItem componentsSeparatedByString:@"="];
        [queryItemsDict setValue:splitString[1] forKey:splitString[0]];
    }
    
    return queryItemsDict[name];
}

-(NSString *)valueForFirstQueryItemNamed:(NSString *)name {
    
    NSURLComponents *urlComps = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:nil];
    NSArray *queryItems = urlComps.queryItems;
    for(NSURLQueryItem *queryItem in queryItems) {
        if ([queryItem.name isEqualToString:name]) {
            return queryItem.value;
        }
    }
    
    return nil;
}


@end
