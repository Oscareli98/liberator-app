//
//  ArticleListViewController.h
//  Liberator
//
//  Created by Oscar Newman on 9/1/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHandler.h"

#import "GRMustache.h"

@interface ArticleListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, retain) ArticleHandler *articleHandler;
@property (nonatomic, retain) GRMustacheTemplate *articleTemplate;

@end
