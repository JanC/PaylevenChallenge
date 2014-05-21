//
// Created by dev on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLListViewController.h"


@interface PLListViewController()

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation PLListViewController {

}

- (void)loadView {
    [super loadView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);

    [self.view addSubview:self.tableView];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:views]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    BoxFolderPickerViewController * boxFolderPickerViewController = [[BoxSDK sharedSDK] folderPickerWithRootFolderID:BoxAPIFolderIDRoot
                                   thumbnailsEnabled:YES
                                cachedThumbnailsPath:nil
                                fileSelectionEnabled:YES];

    [self.navigationController pushViewController:boxFolderPickerViewController animated:YES] ;
}


@end