//
// Created by Jan Chaloupecky on 06/05/14.
// Copyright (c) 2014 Neofonie Mobile GPLH. All rights reserved.
//

#import "UIFont+PLStyle.h"

@implementation UIFont (PLStyle)

#pragma mark  
#pragma mark - Generic Fonts -



+ (UIFont *)regularFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"ProximaNova-Regular" size:size];
}


#pragma mark  
#pragma mark - Fonts by use Case -

#pragma mark  
#pragma mark Bars

/// as used in
+ (UIFont *)PLNavigationBarFont
{
    return [UIFont regularFontWithSize:18.0f];
}

#pragma mark  



#pragma mark  
#pragma mark Table View Cells



+ (UIFont *)PLDefaultTextFont
{
    return [self regularFontWithSize:17];
}

+ (UIFont *)PLDefaultSmallTextFont
{
    return [self regularFontWithSize:15];
}

+ (UIFont *)PLDefaultBoldTextFont
{
    return [self regularFontWithSize:17];
}
+ (UIFont *)PLDefaultBoldSmallTextFont
{
    return [self regularFontWithSize:15];
}

@end
