//
// Created by dev on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLFile;
@class PLListArrayDataSource;

@interface PLListViewController : UIViewController <UITableViewDelegate>

-(id) initWithRootFolder;
-(id) initWithFolder:(PLFile *) folder;

@end