//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLBoxAPIClient.h"
#import "PLFile.h"
#import "PLJSONParser.h"
#import "NSError+PLError.h"
#import "NSURL+PLURL.h"

#pragma mark - Constants

NSString *const PLBoxAPIClientBaseURL = @"https://api.box.com/2.0/";
NSString *const PLBoxAPIListFolderPath = @"folders/%@/items";

@interface PLBoxAPIClient ()

@property(nonatomic, strong, readwrite) NSString *clientID;
@property(nonatomic, strong, readwrite) NSString *authorizationToken;

@property(nonatomic, strong) id <PLParser> parser;
@end

@implementation PLBoxAPIClient
{
}

- (instancetype)initWithAuthorizationToken:(NSString *)authorizationToken
{
    self = [super init];

    if (self)
    {

        // Since I did not implement the autorization, I just the SDK directly here
        authorizationToken = [BoxSDK sharedSDK].OAuth2Session.accessToken;

        NSLog(@"Auth token is %@", authorizationToken);

        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

        sessionConfig.HTTPAdditionalHeaders = @{
            @"Authorization" : [NSString stringWithFormat:@"Bearer %@", authorizationToken],
        };

        self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
        self.authorizationToken = authorizationToken;
        self.parser = [[PLJSONParser alloc] init];
    }

    return self;
}

#pragma mark - Public

- (void)fetchFolderItems:(PLFile *)folder withCompletion:(PLFetchFolderCompletion)completion
{

    NSURLRequest *request = [self PLURLForListItemInFolder:folder];

    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

            NSArray *plFiles;
            NSError *apiError = error;

            if (httpResponse.statusCode == 200)
            {
                plFiles = [self.parser parseFileItemsWithData:data];
            }
            else
            {
                //
                // dummy error handling
                //
                apiError = [NSError errorWithPLCode:httpResponse.statusCode];
            }

            completion(plFiles, apiError);
        }] resume];
}

- (NSURLRequest *)PLURLForListItemInFolder:(PLFile *)folder
{
    NSString *path = [NSString stringWithFormat:PLBoxAPIListFolderPath, folder.uid ? folder.uid:@"0"];
    NSString *urlString = [PLBoxAPIClientBaseURL stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:urlString];

    url = [url URLByAppendingQueryString:@"fields=name,created_at"];

    return [NSURLRequest requestWithURL:url];
}

- (void)requestAuthTicketWithCompletion:(void (^)())completion
{
}

@end