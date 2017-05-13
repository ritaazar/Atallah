//
//  ContactUsViewController.m
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/14/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "ContactUsViewController.h"
#import "CommonMacros.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigation];
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
    self.navigationItem.title = @"Contact Us";
}

- (IBAction)goToFacebook:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://m.facebook.com/groups/106968459356542?tsid=0.6779455174691975&source=typeahead"]];
}

- (IBAction)goToWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://atallahmaronite.com"]];
}

- (IBAction)goToEmailUs:(id)sender
{
    NSURL* mailURL = [NSURL URLWithString:@"mailto:atallah.maronite@gmail.com"];
    if ([[UIApplication sharedApplication] canOpenURL:mailURL]) {
        [[UIApplication sharedApplication] openURL:mailURL];
    }
}

@end
