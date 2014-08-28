//
//  MasterViewController.h
//  Liberator
//
//  Created by Oscar Newman on 8/27/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
