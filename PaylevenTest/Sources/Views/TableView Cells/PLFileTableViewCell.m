//
// Created by Jan on 22/05/14.
// Copyright (c) 2014 dev. All rights reserved.
//

#import "PLFileTableViewCell.h"
#import "UIColor+PLStyle.h"
#import "UIFont+PLStyle.h"

@implementation PLFileTableViewCell
{
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self)
    {

        //
        // Style
        //
        self.textLabel.textColor = [UIColor PLDefaultTextColor];
        self.textLabel.font = [UIFont PLDefaultTextFont];

        self.detailTextLabel.textColor = [UIColor PLLightTextGrayColor];
        self.detailTextLabel.font = [UIFont PLDefaultSmallTextFont];
    }

    return self;
}

@end