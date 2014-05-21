//
// Created by dev on 20/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLListViewController.h"
#import "PLFile.h"
#import "PLFileManager.h"

NSString *const PLListViewControllerCellId = @"PLListViewControllerCellId";

@interface PLListViewController ()

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) NSArray *plFiles;
@property(nonatomic, strong, readwrite) PLFile *currentFolder;

@end

@implementation PLListViewController
{
}

-(id) initWithRootFolder
{
    return [self initWithFolder:nil];
}
-(id) initWithFolder:(PLFile *) folder
{
    self = [self init];
    if(self)
    {
        self.currentFolder = folder;
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PLListViewControllerCellId];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

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
    [self triggerRefresh];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PLListViewControllerCellId forIndexPath:indexPath];

    //
    // configure cell
    //
    PLFile *file = self.plFiles[indexPath.row];
    cell.textLabel.text = file.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PLFile *file = self.plFiles[indexPath.row];
    if(file.isDirectory)
    {
        [self.navigationController pushViewController:[[PLListViewController alloc] initWithFolder:file] animated:YES];
    }

}

#pragma mark - Helpers

-(void) triggerRefresh
{
    [[PLFileManager sharedManager] listFilesInFolder:self.currentFolder completion:^(NSArray *plFiles, NSError *error) {
        self.plFiles = plFiles;
        [self.tableView reloadData];
    }];
}

@end