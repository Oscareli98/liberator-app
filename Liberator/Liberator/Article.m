//
//  Article.m
//  Liberator
//
//  Created by Oscar Newman on 8/28/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "Article.h"

@implementation Article

- (id)initWithParameters:(NSDictionary*)parameters{
    self = [super init];
    if(self) {
        self.title = parameters[@"title"];
        self.body = parameters[@"body"];
        self.author = parameters[@"author"];
        self.featureImage = parameters[@"featuredImage"];
        self.excerpt = parameters[@"excerpt"];
        self.postURL = parameters[@"postURL"];
        self.date = parameters[@"date"];
        
        self.category = parameters[@"category"];
        if ([[self.category lowercaseString] isEqualToString:@"uncategorized"] || [[self.category lowercaseString] isEqualToString:@"photo of the day"] || [[self.category lowercaseString] isEqualToString:@"news"]) {
            self.category = nil;
        }
    }
    
    _articleTemplate = [GRMustacheTemplate templateFromResource:@"article_2" bundle:nil error:NULL];
    
    return self;
}

- (BOOL)hasFeatureImage{
//    NSLog(@"%@", self.featureImage);
    return ![self.featureImage isEqualToString: @""];
}

-(NSString*)getHTML
{
    return [_articleTemplate renderObject:self error:NULL];
}




@end
