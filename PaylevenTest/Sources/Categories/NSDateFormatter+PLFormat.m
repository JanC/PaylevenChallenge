//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "NSDateFormatter+PLFormat.h"

@implementation NSDateFormatter (PLFormat)

+ (NSDateFormatter *)PLParseFormatter
{
    static NSDateFormatter *parseFormatter;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        parseFormatter = [[NSDateFormatter alloc] init];
        [parseFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        // Need to force US locale when generating otherwise it might not be 8601 compatible
        [parseFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [parseFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [parseFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    });

    return parseFormatter;
}

+ (NSDateFormatter *)PLUIDateFormatter
{
    static NSDateFormatter *uiDateFormatter;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        uiDateFormatter = [[NSDateFormatter alloc] init];
        [uiDateFormatter setDateFormat:@"d. MMMM yyyy"];
    });

    // set this all the time in case the user changes the locale while the app is running
    [uiDateFormatter setLocale:[NSLocale currentLocale]];

    return uiDateFormatter;
}

@end
