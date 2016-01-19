//
//  ArticleListViewController.m
//  Liberator
//
//  Created by Oscar Newman on 9/1/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "ArticleListViewController.h"

@interface ArticleListViewController ()

@end

@implementation ArticleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)awakeFromNib
{
    NSLog(@"didInit");
    _articleTemplate = [GRMustacheTemplate templateFromResource:@"article_list" bundle:nil error:NULL];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.557 green:0.267 blue:0.678 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSFontAttributeName: [UIFont fontWithName:@"Didot-Bold" size:18.0f]
                                                                       }];
    self.articleHandler = [[ArticleHandler alloc] init];
    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    [_webView.scrollView addSubview:refreshControl];
    
//    [refreshControl beginRefreshing];
//    [self refresh];
    [self loadHTML];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHTML
{
    // Update the user interface for the detail item.
    NSString *articleHTML = [_articleTemplate renderObject:_articleHandler error:NULL];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //    NSLog(@"%@", articleHTML);
    [self.webView loadHTMLString:articleHTML baseURL:baseURL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
