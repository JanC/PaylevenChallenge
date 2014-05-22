//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PLConfigureCellBlock)(UITableViewCell *cell, id modelObject);

@interface PLListArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readwrite) NSArray *dataSource;

- (id)initWithTableView:(UITableView *)tableView
        reuseIdentifier:(NSString *)reuseIdentifier
              cellClass:(Class)cellClass
     configureCellBlock:(PLConfigureCellBlock)configureCellBlock;

-(id) modelObjectForIndexPath:(NSIndexPath *) indexPath;

@end