//
// Created by Jan on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PLFile;
@class PLBoxAPIClient;

typedef void (^PLFileManagerListCompletionBlock)(NSArray *plFiles, NSError *error);
typedef void (^PLProgressBlock)(CGFloat progress);
typedef void (^PLFileManagerUploadCompletionBlock)(PLFile *uploadedFile, NSError *error);

@interface PLFileManager : NSObject

+ (id)sharedManager;

-(void) listFilesInFolder:(PLFile *) folder completion:(PLFileManagerListCompletionBlock) completion;

- (void)uploadFile:(PLFile *)file progress:(PLProgressBlock)progress completion:(PLFileManagerUploadCompletionBlock)completion;
@end