//
// Created by Jan Chaloupecky on 29/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PLErrorDomain;

typedef NS_ENUM(NSInteger, PLErrorCode) {
    SPErrorCodeBadRequest = 400,
    SPErrorCodeUnauthorised = 401,
    SPErrorCodeNotFound = 404,
    SPErrorCodeInternalError = 500,
    SPErrorCodeBadGateway = 502,
    SPErrorCodeInvalidSignature = 1000,

};

@interface NSError (PLError)

+ (instancetype)errorWithPLCode:(PLErrorCode)errorCode;

@end