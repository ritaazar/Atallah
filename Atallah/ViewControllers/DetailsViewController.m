//
//  DetailsViewController.m
//  AttalahMaronite
//
//  Created by Azar, Rita on 5/29/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "DetailsViewController.h"
#import "CommonMacros.h"

@implementation DetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initMemberValues];
    //[self initImage];
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
    self.navigationItem.title = @"Member Details";
}
-(void) initMemberValues
{
    self.firstNameValue.text = _member.firstName != nil ? _member.firstName : @"-";
    self.middleNameValue.text = _member.middleName != nil ? _member.middleName : @"-";
    self.lastNameValue.text = _member.lastName != nil ? _member.lastName : @"-";
    self.motherNameValue.text = _member.motherName != nil ? _member.motherName : @"-";
    self.motherLastNameValue.text = _member.motherLastName != nil ? _member.motherLastName : @"-";
    self.genderValue.text = _member.gender != nil ? _member.gender : @"-";
    self.mobileNumberValue.text = _member.mobileNumber != nil ? _member.mobileNumber : @"-";
    self.emailValue.text = ![self isNilOrEmpty: _member.emailAddress] ? _member.emailAddress : @"-";
    self.jobValue.text = _member.job ? _member.job : @"-";
    self.bloodTypeValue.text = _member.bloodType != nil ? _member.bloodType : @"-";
    self.canDonateValue.text = _member.canDonate != nil ? _member.canDonate : @"-";
    self.addressValue.text = _member.address != nil ? _member.address : @"-";
    self.hometownValue.text = _member.hometown != nil ? _member.hometown : @"-";
}

-(void) initImage
{
    //1
    NSURL *url = [NSURL URLWithString:
                  @"http://atallahmaronite.com/images/AppMembers/CusineDart.png"];
    
    [self.activationIndicator startAnimating];
    // 2
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       // 3
                                                       UIImage *downloadedImage = [UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:location]];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           NSLog(@"stopAnimating");
                                                           self.memberImage.image = downloadedImage;
                                                           [self.activationIndicator stopAnimating];
                                                       });
                                                   }];
    
    // 4	
    [downloadPhotoTask resume];
}

-(BOOL) isNilOrEmpty:(NSString *)value
{
    return (value == nil || [value isEqualToString:@""]);
}
@end
