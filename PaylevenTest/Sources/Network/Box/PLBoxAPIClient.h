//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PLFetchFolderCompletion)(NSArray *plFiles, NSError *error);

@class PLFile;
@class PLJSONParser;

@interface PLBoxAPIClient : NSObject

@property(nonatomic, strong) NSURLSession *session;

- (instancetype)initWithAuthorizationToken:(NSString *)authorizationToken;

/**
* http://developers.box.com/authentication-in-your-ios-app/
*/
-(void) requestAuthTicketWithCompletion:(void (^)()) completion;

- (void)fetchFolderItems:(PLFile *) folder withCompletion:(PLFetchFolderCompletion) completion;

@end