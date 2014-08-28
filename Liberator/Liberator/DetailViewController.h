//
//  DetailViewController.h
//  Liberator
//
//  Created by Oscar Newman on 8/27/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
