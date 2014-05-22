

#import "UIColor+PLStyle.h"
#import "HexColor.h"

@implementation UIColor (PLStyle)

#pragma mark  
#pragma mark - Default Colors -

+ (UIColor *)PLTintColor
{
    return [UIColor colorWithHexString:@"#1092B7"];

}

#pragma mark  
#pragma mark Text Colors
+ (UIColor *)PLDefaultTextColor
{
    return [UIColor colorWithHexString:@"#28384C"];

}
+ (UIColor *)PLLightTextGrayColor
{
    return [UIColor colorWithHexString:@"#8E8E93"];
}

+ (UIColor *)PLLinkTextColor
{
    return [UIColor colorWithHexString:@"#2666B5"];
}

@end
