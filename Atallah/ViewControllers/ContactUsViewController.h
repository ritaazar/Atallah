//
//  ContactUsViewController.h
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/14/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *emailUsButton;
@property (strong, nonatomic) IBOutlet UIButton *faceBookButton;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;
- (IBAction)goToFacebook:(id)sender;
- (IBAction)goToWebsite:(id)sender;
- (IBAction)goToEmailUs:(id)sender;

@end
