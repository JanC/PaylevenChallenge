//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLFileTableViewCell.h"
#import "PLFile.h"

@interface PLFileTableViewCell (PLConfigureForFile)

- (void)configureForFile:(PLFile *)file;

@end