//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLFile+PLBoxFile.h"
#import "NSDateFormatter+PLFormat.h"

@implementation PLFile (PLBoxFile)

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if ( self )
    {
        self.uid = dictionary[@"id"];
        self.directory = [dictionary[@"type"] isEqualToString:@"folder"];
        self.name = dictionary[@"name"];
        self.creationDate = [[NSDateFormatter PLParseFormatter] dateFromString:dictionary[@"created_at"]];
    }
    return self;
}
@end