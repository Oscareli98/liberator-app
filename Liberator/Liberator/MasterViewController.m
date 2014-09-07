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
#import "ArticleTableViewCell.h"
#import "PhotoArticleTableViewCell.h"
#import "NSString+StripHTML.h"

#import "UIImageView+WebCache.h"



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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.557 green:0.267 blue:0.678 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                            NSFontAttributeName: [UIFont fontWithName:@"Didot-Bold" size:20.0f]
                                                            }];
    self.articleHandler = [[ArticleHandler alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
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
    return [self.articleHandler.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell *cell;
    Article *article = _articleHandler.articles[indexPath.row];

    if([article hasFeatureImage]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"article_with_picture" forIndexPath:indexPath];
        [((PhotoArticleTableViewCell*)cell).featureImage sd_setImageWithURL:[NSURL URLWithString:article.featureImage]];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"article_no_picture" forIndexPath:indexPath];
    }
    
    cell.title.text = article.title;
    cell.summary.selectable = YES;
    cell.summary.text = [article.excerpt stripHTML];
    
    [cell updateConstraints];
    
//    NSDate *object = _objects[indexPath.row];
//    cell.textLabel.text = [object description];
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
