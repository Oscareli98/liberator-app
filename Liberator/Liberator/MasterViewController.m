//
//  MasterViewController.m
//  Liberator
//
//  Created by Oscar Newman on 8/27/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//
#include <stdlib.h>
#import "MasterViewController.h"
#import "ArticleViewController.h"
#import "Article.h"
#import "PhotoArticleTableViewCell.h"
#import "NSString+StripHTML.h"
#import "NSString+HTML.h"


#import "UIImageView+WebCache.h"
#import "SWRevealViewController.h"

#import "Liberator-Swift.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);

    }
    [super awakeFromNib];
    _category = @"";

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    SDFeedParser *feedParser = [[SDFeedParser alloc]init];
//    [feedParser parseURL:@"http://yourBlog.com/?json=1" success:^(NSArray *postsArray, NSInteger postsCount) {
//        
//        NSLog(@"Fetched %ld posts", postsCount);
//        NSLog(@"Posts: %@", postsArray);
//        
//    }failure:^(NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
    
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.557 green:0.267 blue:0.678 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                            NSFontAttributeName: [UIFont fontWithName:@"Didot-Bold" size:20.0f]
                                                            }];
    
    self.articleHandler = [[ArticleHandler alloc] init];
    self.articleHandler.category = _category;
    
    if ([_category isEqualToString: @""]) {
        [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                           NSFontAttributeName: [UIFont fontWithName:@"Didot-Bold" size:20.0f]
                                                                           }];
    }
    else {
        self.title = [_category capitalizedString];
        [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]
                                                                           }];
    }
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    CGPoint newOffset = CGPointMake(0, -[self.tableView contentInset].top);
    [self.tableView setContentOffset:newOffset animated:YES];
    [self.refreshControl beginRefreshing];
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    [_articleHandler loadArticles:self];

}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ArticleTableViewCell *cell;
//    Article *article = _articles[indexPath.row];
//
//    if([article hasFeatureImage]){
//        cell = [tableView dequeueReusableCellWithIdentifier:@"article_with_picture" forIndexPath:indexPath];
//        [((PhotoArticleTableViewCell*)cell).featureImage sd_setImageWithURL:[NSURL URLWithString:article.featureImage]];
//    }
//    else{
//        cell = [tableView dequeueReusableCellWithIdentifier:@"article_no_picture_label" forIndexPath:indexPath];
//    }
//    
//    cell.title.text = [article.title capitalizedString];
//    cell.summary.selectable = YES;
//    cell.summary.text = [article.excerpt stripHTML];
//    
//    [cell updateConstraints];
//    
////    NSDate *object = _objects[indexPath.row];
////    cell.textLabel.text = [object description];
//    return cell;

    ArticleAttributedCell *cell;
    Article *article = _articles[indexPath.row];
    
    if([article hasFeatureImage]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"article_label" forIndexPath:indexPath];
        [cell.feature_image sd_setImageWithURL:[NSURL URLWithString:article.featureImage]];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"article_no_picture_label" forIndexPath:indexPath];
    }
    
    NSString *title = [[article.title stringByDecodingHTMLEntities] stringByAppendingString:@"\n"];
    NSString *body = [[[article.excerpt stringByDecodingHTMLEntities] stringByConvertingHTMLToPlainText] stringByReplacingOccurrencesOfString:@"Share this: Twitter Facebook Email Print" withString:@""];
    
    NSString *combined = [title stringByAppendingString:body];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:combined];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Georgia" size:20] range:NSMakeRange(0, title.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:13] range:NSMakeRange(title.length, body.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.333 alpha:1.000] range:NSMakeRange(title.length, body.length)];
    
    cell.attr_string.attributedText = attr;
    [cell.attr_string sizeToFit];
    

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"view-article" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"view-article"]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        ArticleViewController *avc = (ArticleViewController*)[segue destinationViewController];
        avc.article = self.articleHandler.articles[self.tableView.indexPathForSelectedRow.row];
        [avc viewDidLoad];
        [avc loadHTML];
    }
}

@end
