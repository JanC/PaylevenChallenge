//
// Created by Jan Chaloupecky on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLFileTableViewCell+PLConfigureForFile.h"

#import "NSDateFormatter+PLFormat.h"

@implementation PLFileTableViewCell (PLConfigureForFile)

- (void)configureForFile:(PLFile *)file
{
    self.textLabel.text = file.name;
    self.imageView.image = file.isDirectory ? [UIImage imageNamed:@"folder"] : [UIImage imageNamed:@"file"];
    self.accessoryType = file.isDirectory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;

    NSString *creationDateString = [[NSDateFormatter PLUIDateFormatter] stringFromDate:file.creationDate];
    self.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Created at %@",), creationDateString];
}

@end