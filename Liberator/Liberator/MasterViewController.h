//
//  MasterViewController.h
//  Liberator
//
//  Created by Oscar Newman on 8/27/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHandler.h"

@class ArticleViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) ArticleViewController *detailViewController;
@property (nonatomic, retain) ArticleHandler *articleHandler;

@end
