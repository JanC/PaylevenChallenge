//
// Created by Jan on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PLFile;
@class PLBoxAPIClient;

typedef void (^PLFileManagerListCompletionBlock)(NSArray *plFiles, NSError *error);

@interface PLFileManager : NSObject

+ (id)sharedManager;

-(void) listFilesInFolder:(PLFile *) folder completion:(PLFileManagerListCompletionBlock) completion;
@end