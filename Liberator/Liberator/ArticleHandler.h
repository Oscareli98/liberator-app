//
//  ArticleHandler.h
//  Liberator
//
//  Created by Oscar Newman on 8/29/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleHandler : NSObject

@property (nonatomic, retain) NSMutableArray *articles;

@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) NSString* category;

- (NSData *) getDataFrom:(NSString *)url;
- (void)loadArticles:(UITableViewController*)controller;
@end
