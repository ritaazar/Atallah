//
//  DetailsViewController.h
//  AttalahMaronite
//
//  Created by Azar, Rita on 5/29/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *firstNameValue;
@property (strong, nonatomic) IBOutlet UILabel *middleNameValue;
@property (strong, nonatomic) IBOutlet UILabel *lastNameValue;
@property (strong, nonatomic) IBOutlet UILabel *motherNameValue;
@property (strong, nonatomic) IBOutlet UILabel *motherLastNameValue;
@property (strong, nonatomic) IBOutlet UILabel *genderValue;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberValue;
@property (strong, nonatomic) IBOutlet UILabel *emailValue;
@property (strong, nonatomic) IBOutlet UILabel *jobValue;
@property (strong, nonatomic) IBOutlet UILabel *bloodTypeValue;
@property (strong, nonatomic) IBOutlet UILabel *canDonateValue;
@property (strong, nonatomic) IBOutlet UILabel *addressValue;
@property (strong, nonatomic) IBOutlet UILabel *hometownValue;
@property (strong, nonatomic) IBOutlet UIImageView *memberImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activationIndicator;

@property (strong, nonatomic) Member *member;
@end
