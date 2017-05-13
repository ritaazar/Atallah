//
//  AboutUsViewController.m
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/2/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "AboutUsViewController.h"
#import "CommonMacros.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    _aboutUsTextView.editable = NO;
    _titleTextView.editable = NO;
}

-(void) initNavigation
{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [self.navigationController.navigationBar setBarTintColor:DARK_BEIGE];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]}];
    self.navigationItem.title = @"About Us";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
