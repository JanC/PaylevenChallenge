//
// Created by Jan Chaloupecky on 21/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLBoxAPIClient.h"
#import "PLFile.h"
#import "PLJSONParser.h"
#import "NSError+PLError.h"
#import "NSURL+PLURL.h"
#import "PLFileManager.h"
#import "PKMultipartInputStream.h"

#pragma mark - Constants

NSString *const PLBoxAPIClientBaseURL = @"https://api.box.com/2.0/";
NSString *const PLBoxAPIListFolderPath = @"folders/%@/items";

NSString *const PLBoxAPIClientUploadBaseURL = @"https://upload.box.com/api/2.0/files/content";

@interface PLBoxAPIClient () <NSURLSessionTaskDelegate, NSURLSessionDelegate>

@property(nonatomic, strong, readwrite) NSString *clientID;
@property(nonatomic, strong, readwrite) NSString *authorizationToken;
@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) NSURLSession *uploadSession;

@property(nonatomic, strong) id <PLParser> parser;
@property(nonatomic, copy) PLUploadCompletionBlock currentCompletionBlock;
@property(nonatomic, copy) PLProgressBlock currentProgressBlock;
@end

@implementation PLBoxAPIClient
{
}

- (instancetype)initWithAuthorizationToken:(NSString *)authorizationToken
{
    self = [super init];

    if ( self )
    {

        // Since I did not implement the autorization, I just the SDK directly here
        authorizationToken = [BoxSDK sharedSDK].OAuth2Session.accessToken;

        NSLog(@"Auth token is %@", authorizationToken);

        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

        sessionConfig.HTTPAdditionalHeaders = @{
                @"Authorization" : [NSString stringWithFormat:@"Bearer %@", authorizationToken],
        };

        self.uploadSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                           delegate:self
                                                      delegateQueue:nil];

        self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
        self.authorizationToken = authorizationToken;
        self.parser = [[PLJSONParser alloc] init];
    }

    return self;
}

#pragma mark - Public

- (void)fetchFolderItems:(PLFile *)folder withCompletion:(PLFetchFolderCompletion)completion
{

    NSURLRequest *request = [self URLForListItemInFolder:folder];

    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

        NSArray *plFiles;
        NSError *apiError = error;

        if ( httpResponse.statusCode == 200 )
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

- (void)requestAuthTicketWithCompletion:(void (^)())completion
{
}

- (void)uploadFile:(PLFile *)file progress:(PLProgressBlock)progress completion:(PLUploadCompletionBlock)completion
{
    self.currentCompletionBlock = completion;
    self.currentProgressBlock = progress;

    NSURLSessionUploadTask *uploadTask = [self.uploadSession uploadTaskWithStreamedRequest:[self URLForUpload:file]];
    [uploadTask resume];
}

#pragma Mark - NSURLSessionTaskDelegate


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
        totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    if(totalBytesExpectedToSend != NSURLSessionTransferSizeUnknown)
    {
        float progress = (float) totalBytesSent / (float) totalBytesExpectedToSend;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentProgressBlock(progress);
        });
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentCompletionBlock(nil, error);
    });
}

#pragma mark - Helper

- (NSURLRequest *)URLForListItemInFolder:(PLFile *)folder
{
    NSString *path = [NSString stringWithFormat:PLBoxAPIListFolderPath, folder.uid ? folder.uid : @"0"];
    NSString *urlString = [PLBoxAPIClientBaseURL stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:urlString];

    url = [url URLByAppendingQueryString:@"fields=name,created_at"];

    return [NSURLRequest requestWithURL:url];
}

- (NSURLRequest *)URLForUpload:(PLFile *) plFile
{
    NSURL *url = [NSURL URLWithString:PLBoxAPIClientUploadBaseURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    PKMultipartInputStream *body = [[PKMultipartInputStream alloc] init];
    [body addPartWithName:@"parent_id" string:@"0"];


    [body addPartWithName:@"filename" filename:plFile.name stream:[NSInputStream inputStreamWithData:plFile.data] streamLength:plFile.data.length];

    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", [body boundary]] forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBodyStream:body];

    [request setHTTPMethod:@"POST"];
    return request;
}

@end