//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLListArrayDataSource.h"

@interface PLListArrayDataSource ()

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, copy, readwrite) NSString *reuseIdentifier;
@property(nonatomic, copy, readwrite) PLConfigureCellBlock configureCellBlock;

@end

@implementation PLListArrayDataSource
{
}

- (id)initWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier cellClass:(Class)cellClass configureCellBlock:(PLConfigureCellBlock)configureCellBlock
{
    self = [super init];

    if (self)
    {
        self.configureCellBlock = configureCellBlock;
        self.reuseIdentifier = reuseIdentifier;
        self.tableView = tableView;

        self.tableView.dataSource = self;
        [self.tableView registerClass:cellClass forCellReuseIdentifier:self.reuseIdentifier];
    }

    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];

    self.configureCellBlock(cell, [self modelObjectForIndexPath:indexPath]);

    return cell;
}

#pragma mark - Public

- (id)modelObjectForIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource[(NSUInteger)indexPath.row];
}

#pragma mark - Accessors

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

@end