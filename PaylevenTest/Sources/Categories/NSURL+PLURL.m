//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "NSURL+PLURL.h"

@implementation NSURL (PLURL)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString
{
    if (![queryString length])
    {
        return self;
    }

    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", [self absoluteString],
                           [self query] ? @"&"            :@"?", queryString];
    NSURL *theURL = [NSURL URLWithString:URLString];

    return theURL;
}
@end