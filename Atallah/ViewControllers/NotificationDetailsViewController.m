//
//  NotificationDetailsViewController.m
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/2/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "NotificationDetailsViewController.h"
#import "CommonMacros.h"

@interface NotificationDetailsViewController ()

@end

@implementation NotificationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    _dateTextView.editable = NO;
    _notificationTextView.editable = NO;
    
    _dateTextView.text = self.notificationDate;
    _notificationTextView.text = self.notificationText;
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
    self.navigationItem.title = @"News Details";
}

@end
