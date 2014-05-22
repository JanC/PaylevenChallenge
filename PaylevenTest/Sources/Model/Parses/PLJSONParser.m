//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLJSONParser.h"
#import "PLFile.h"
#import "PLFile+PLBoxFile.h"

@implementation PLJSONParser
{
}

- (NSArray *)parseFileItemsWithData:(NSData *)data
{
    NSError *error;
    NSMutableArray *plFileArray = [NSMutableArray array];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    if (error)
    {
        NSLog(@"parse error %@", error);
    }
    else
    {
        NSArray *entries = json[@"entries"];
        [entries enumerateObjectsUsingBlock:^(NSDictionary *entry, NSUInteger idx, BOOL *stop) {
            [plFileArray addObject:[[PLFile alloc] initWithDictionary:entry]];
        }];
    }

    return [NSArray arrayWithArray:plFileArray];
}

@end