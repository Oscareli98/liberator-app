//
//  DetailViewController.m
//  Liberator
//
//  Created by Oscar Newman on 8/27/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleHandler.h"
#import "Article.h"


@interface ArticleViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation ArticleViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self loadHTML];
}

- (void)loadHTML
{
    // Update the user interface for the detail item.
    
    NSString *articleHTML = [_article getHTML];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSLog(@"%@", articleHTML);
    [self.webView loadHTMLString:articleHTML baseURL:baseURL];
}

- (IBAction)openShareSheet:(id)sender {
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    [sharingItems addObject:_article.postURL];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [activityController setValue:[NSString stringWithFormat:@"%@ – The Liberator", _article.title] forKey:@"subject"];

    [self presentViewController:activityController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
