//
//  ArticleTableViewCell.h
//  Liberator
//
//  Created by Oscar Newman on 8/30/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UITextView *summary;


@end
