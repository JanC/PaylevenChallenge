//
// Created by Jan on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFile : NSObject

@property (nonatomic, strong, readwrite) NSString *uid;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite, getter=isDirectory) NSString *directory;

@end