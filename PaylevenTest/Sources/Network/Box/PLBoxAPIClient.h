//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLFileManager.h"

@class PLFile;

typedef void (^PLFetchFolderCompletion)(NSArray *plFiles, NSError *error);

typedef void (^PLUploadCompletionBlock)(PLFile *uploadedFile, NSError *error);

@class PLFile;
@class PLJSONParser;

@interface PLBoxAPIClient : NSObject

- (instancetype)initWithAuthorizationToken:(NSString *)authorizationToken;

/**
* http://developers.box.com/authentication-in-your-ios-app/
*/
-(void) requestAuthTicketWithCompletion:(void (^)()) completion;

- (void)fetchFolderItems:(PLFile *) folder withCompletion:(PLFetchFolderCompletion) completion;

- (void)uploadFile:(PLFile *) file progress:(PLProgressBlock) progress completion:(PLUploadCompletionBlock) completion;

@end