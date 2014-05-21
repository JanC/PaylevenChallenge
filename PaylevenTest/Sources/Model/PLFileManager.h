//
// Created by Jan on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLFile;

typedef void (^PLFileManagerListCompletionBlock)(NSArray *files, NSError *error);

@interface PLFileManager : NSObject

-(void) listFilesInFolder:(PLFile *) folder completion:(PLFileManagerListCompletionBlock) completion;
@end