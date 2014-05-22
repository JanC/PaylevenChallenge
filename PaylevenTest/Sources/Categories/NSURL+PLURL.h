//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (PLURL)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;

@end