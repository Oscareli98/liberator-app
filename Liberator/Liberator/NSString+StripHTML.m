//
//  NSString+StripHTML.m
//  Liberator
//
//  Created by Oscar Newman on 8/30/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "NSString+StripHTML.h"

@implementation NSString (StripHTML)
- (NSString *)stripHTML
{
    NSRange range;
    NSString *str = [self copy];
    while ((range = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:range withString:@""];
    return str;
}
@end
