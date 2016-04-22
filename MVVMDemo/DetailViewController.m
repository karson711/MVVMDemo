//
//  DetailViewController.m
//  MVVMDemo
//
//  Created by kunge on 16/4/22.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.detailWebView.scrollView.showsVerticalScrollIndicator = NO;
    [self.detailWebView setDelegate:self];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [self.detailWebView loadRequest:request];
}

#pragma mark - UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


@end
