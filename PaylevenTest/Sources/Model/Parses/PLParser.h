//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PLParser <NSObject>

-(NSArray *) parseFileItemsWithData:(NSData *) data;

@end