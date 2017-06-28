//
//  RegistrationViewController.h
//  TestBackgroundImage
//
//  Created by Azar, Rita on 4/14/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "AtallahNavigationController.h"
#import "AppDelegate.h"
#import "RegistrationInfo+CoreDataClass.h"

@interface RegistrationViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionDelegate, DownPickerParentDelegate>
{
    BOOL canDonate;
    NSMutableData *receiveData;
    AtallahNavigationController *destinationView;
    NSString *fullName;
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *middleName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *motherName;
@property (weak, nonatomic) IBOutlet UITextField *motherLastName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *hometown;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (weak, nonatomic) IBOutlet UITextField *otherJobDescription;
@property (weak, nonatomic) IBOutlet UITextField *bloodType;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadImage;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
@property (strong, nonatomic) IBOutlet UIButton *skipButton;

@property (strong, nonatomic) DownPicker *genderDownPicker;
@property (strong, nonatomic) DownPicker *jobDownPicker;
@property (strong, nonatomic) DownPicker *bloodTypeDownPicker;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (assign) BOOL isEditingMode;
@property (strong, nonatomic) RegistrationInfo *registrationInfo;

- (IBAction)editObjectImage:(id)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
