//
// Created by Jan on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLFileManager.h"
#import "PLFile.h"
#import "PLBoxAPIClient.h"

@interface PLFileManager ()

@property(nonatomic, strong) PLBoxAPIClient *apiClient;
@end

@implementation PLFileManager
{
}

+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    static PLFileManager *instance;

    dispatch_once(&onceToken, ^{

        //
        // This should not be a singleton.
        // The manager should be instantiated with a configurable box provider (Box, DropBox, ...)
        //
        instance = [[PLFileManager alloc] init];
    });

    return instance;
}

- (id)init
{
    self = [super init];

    if (self)
    {
        self.apiClient = [[PLBoxAPIClient alloc] initWithAuthorizationToken:nil];
    }

    return self;
}

- (void)listFilesInFolder:(PLFile *)folder completion:(PLFileManagerListCompletionBlock)completion
{

    [self.apiClient fetchFolderItems:folder withCompletion:^(NSArray *plFiles, NSError *error) {

        //
        // Just forward the completion to the caller. Here would be done any local peristance in e.g. core data
        //
        dispatch_async(dispatch_get_main_queue(), ^{
                completion(plFiles, error);
            });

    }];
}
@end