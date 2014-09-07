//
//  ArticleTableViewCell.m
//  Liberator
//
//  Created by Oscar Newman on 8/30/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

//- (void)setTitleText:(NSString*)title
//{
//    //Calculate the expected size based on the font and linebreak mode of your label
//    // FLT_MAX here simply means no constraint in height
//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    
//    CGSize expectedLabelSize = [title sizeWithFont:_title.font constrainedToSize:maximumLabelSize lineBreakMode:_title.lineBreakMode];
//    CGSize expectedSize = [title bou]
//    
//    //adjust the label the the new height.
//    CGRect newFrame = _title.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    _title.frame = newFrame;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
