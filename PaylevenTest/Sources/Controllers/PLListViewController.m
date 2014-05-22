//
// Created by dev on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLListViewController.h"
#import "PLFile.h"
#import "PLFileManager.h"
#import "PLFileTableViewCell.h"
#import "SVProgressHUD.h"
#import "NSDateFormatter+PLFormat.h"
#import "PLListArrayDataSource.h"
#import "UIColor+PLStyle.h"
#import "PLFileTableViewCell+PLConfigureForFile.h"

NSString *const PLListViewControllerCellId = @"PLListViewControllerCellId";

@interface PLListViewController ()

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) PLFile *currentFolder;

@property(nonatomic, strong) PLListArrayDataSource *dataSource;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation PLListViewController
{
}

- (id)initWithRootFolder
{
    return [self initWithFolder:nil];
}

- (id)initWithFolder:(PLFile *)folder
{
    self = [self init];

    if (self)
    {
        self.currentFolder = folder;
        self.title = folder ? folder.name : @"MyBox";
    }

    return self;
}

- (void)loadView
{
    [super loadView];

    //
    // Setup table view
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[PLFileTableViewCell class] forCellReuseIdentifier:PLListViewControllerCellId];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    //
    // Data source for table
    //
    self.dataSource = [[PLListArrayDataSource alloc] initWithTableView:self.tableView
                                                       reuseIdentifier:PLListViewControllerCellId
                                                             cellClass:[PLFileTableViewCell class] configureCellBlock:^(UITableViewCell *cell, id modelObject) {

        NSAssert([cell isKindOfClass:[PLFileTableViewCell class]], @"The data source must dequeue a %@ cell", NSStringFromClass([PLFileTableViewCell class]));
        NSAssert([modelObject isKindOfClass:[PLFile class]], @"The model object must be  %@", NSStringFromClass([PLFile class]));

        PLFileTableViewCell *fileTableViewCell = (PLFileTableViewCell *)cell;
        [fileTableViewCell configureForFile:modelObject];
    }];
    self.tableView.dataSource = self.dataSource;

    //
    // Setup refresh control
    //
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor PLTintColor];
    [self.refreshControl addTarget:self action:@selector(triggerRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

    //
    // Auto Layout
    //
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:views]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self triggerRefresh:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PLFile *file = [self.dataSource modelObjectForIndexPath:indexPath];

    if (file.isDirectory)
    {
        [self.navigationController pushViewController:[[PLListViewController alloc] initWithFolder:file] animated:YES];
    }
}

#pragma mark - Helpers

- (void)triggerRefresh:(id)sender
{
    [self.refreshControl endRefreshing];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", @"Loading")];

    [[PLFileManager sharedManager] listFilesInFolder:self.currentFolder completion:^(NSArray *plFiles, NSError *error) {
        self.dataSource.dataSource = plFiles;
        [SVProgressHUD dismiss];
    }];
}

@end