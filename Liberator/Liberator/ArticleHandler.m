//
//  ArticleHandler.m
//  Liberator
//
//  Created by Oscar Newman on 8/29/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "ArticleHandler.h"
#import "Article.h"
#import "MasterViewController.h"

@interface ArticleHandler ()
- (void)setArticlesFrom:(NSData *)json;

@end

@implementation ArticleHandler

- (id)init
{
    self = [super init];
    if(self){
        _articles = [[NSMutableArray alloc] init];
        _url = @"http://74.220.219.108/~lbjliber/wp-json/posts/?filter[category_name]=";
        _category = @"";
    }
    
    return self;
}


- (void)loadArticles:(MasterViewController*)controller
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        // Check for saved articles in NSUserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *prefsString = [NSString stringWithFormat:@"articles-%@-json", _category];
        if ([defaults objectForKey:prefsString] != nil) {
            // Last articles saved in JSON, load those, then check the web again
            NSData *old_json = [defaults objectForKey:prefsString];
            [self setArticlesFrom:old_json];
            dispatch_async(dispatch_get_main_queue(), ^{
                controller.articles = _articles;
                [controller.tableView reloadData];
            });

        }
        
        
        NSData *article_data = [self getDataFrom:[_url stringByAppendingString:_category]];
        if(article_data == nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [controller.tableView reloadData];
                [controller.refreshControl endRefreshing];
            });
            return;
        }
        
        _articles = [[NSMutableArray alloc] init];
        [defaults setObject:article_data forKey:prefsString];
        [self setArticlesFrom:article_data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            controller.articles = _articles;
            [controller.refreshControl endRefreshing];
            [controller.tableView reloadData];
        });
    });
}

- (void)setArticlesFrom:(NSData *)json
{
    NSError *error = nil;
    NSArray *articles_array = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (NSDictionary* article_dict in articles_array) {

        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *wordpressDate = [article_dict[@"date"] substringToIndex:10];
//        NSLog(@"Date: %@", wordpressDate);
        NSDate *date = [dateFormatter dateFromString:wordpressDate];
        [dateFormatter setDateFormat:@"d MMM y"];
        NSString *formattedDate = [dateFormatter stringFromDate:date];
//        NSLog(@"Form: Date :%@", formattedDate);
        
        
        NSMutableDictionary *articleParams = [[NSMutableDictionary alloc] initWithDictionary: @{
                                                                                                @"title" : article_dict[@"title"],
                                                                                                @"body" : article_dict[@"content"],
                                                                                                @"author" : article_dict[@"author"][@"name"],
                                                                                                @"excerpt" : article_dict[@"excerpt"],
                                                                                                @"postURL" : article_dict[@"link"],
                                                                                                @"date" : formattedDate,
                                                                                                @"category" : article_dict[@"terms"][@"category"][0][@"name"]
                                                                                                }];
        
        if(![article_dict[@"featured_image"] isKindOfClass:[NSNull class]]){
            [articleParams setObject:article_dict[@"featured_image"][@"source"] forKey:@"featuredImage"];
        }
        else {
            articleParams[@"featuredImage"] = @"";
        }
        Article *current_article = [[Article alloc] initWithParameters:articleParams];
        if (![[current_article.category lowercaseString] isEqualToString:@"online pdf"]) {
            [_articles addObject:current_article];
        }
    }

}

- (NSData *) getDataFrom:(NSString *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }
    
    return oResponseData;
}

@end
