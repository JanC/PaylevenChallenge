//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (PLFormat)

+ (NSDateFormatter *)PLParseFormatter; // parses the string date from the API
+ (NSDateFormatter *)PLUIDateFormatter;


@end
