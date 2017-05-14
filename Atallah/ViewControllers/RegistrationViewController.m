//
//  RegistrationViewController.m
//  TestBackgroundImage
//
//  Created by Azar, Rita on 4/14/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "RegistrationViewController.h"
#import "CommonMacros.h"
#import "DownPicker.h"
#import "AtallahNavigationController.h"
#import "MainViewController.h"
#import "RegistrationInfo.h"
#import <Crashlytics/Crashlytics.h>
#import "AppDelegate.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

@synthesize firstName,middleName,lastName,motherName,motherLastName,phoneNumber,email,address,hometown,sex,job,bloodType, joinButton, uploadImage, checkBox, skipButton;
@synthesize activityIndicator, isEditingMode;

-(void) initNavigation
{
    [self.navigationController.navigationBar setBarTintColor:DARK_BEIGE];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]}];
    if (isEditingMode)
    {
        self.navigationItem.title = @"Edit Account";
    }
    else
    {
        self.navigationItem.title = @"Registration";
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigation];
    hometown.delegate = self;
    
    [firstName setPlaceholder:@"First Name *"];
    [self setTextFieldStyle:firstName];
    
    [self setTextFieldStyle:middleName];
    [middleName setPlaceholder:@"Middle Name *"];
    
    [self setTextFieldStyle:lastName];
    [lastName setPlaceholder:@"Last Name *"];
    
    [self setTextFieldStyle:motherName];
    [motherName setPlaceholder:@"Mother Name *"];
    
    [self setTextFieldStyle:motherLastName];
    [motherLastName setPlaceholder:@"Mother Last Name *"];
    
    [self setTextFieldStyle:sex];
    self.genderDownPicker = [[DownPicker alloc] initWithTextField:self.sex withData:[RegistrationViewController getGenderList] withPlaceHolder:@"Gender *"];
    
    [self setTextFieldStyle:phoneNumber];
    [phoneNumber setPlaceholder:@"Mobile Number *"];
    phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    [self setTextWitoutAutocapitalization:email];
    [email setPlaceholder:@"Email Address"];
    
    [self setTextFieldStyle:job];
    self.jobDownPicker = [[DownPicker alloc] initWithTextField:self.job withData:[RegistrationViewController getJobsList] withPlaceHolder:@"Job *"];
    
    [self setTextFieldStyle:bloodType];
    self.bloodTypeDownPicker = [[DownPicker alloc] initWithTextField:self.bloodType withData:[RegistrationViewController getbloodTypeList] withPlaceHolder:@"Blood Type *"];
    
    [self setTextFieldStyle:address];
    [address setPlaceholder:@"Address *"];
    
    [self setTextFieldStyle:hometown];
    [hometown setPlaceholder:@"Hometown *"];
    
    joinButton.layer.borderColor = LIGHT_BEIGE.CGColor;
    joinButton.layer.borderWidth = 2;
    joinButton.layer.cornerRadius = 5;
    if (isEditingMode)
    {
        [joinButton setTitle:@"Edit Account" forState:UIControlStateNormal];
    }
    else
    {
        [joinButton setTitle:@"Create Account" forState:UIControlStateNormal];
    }
    
    uploadImage.layer.borderColor = LIGHT_BEIGE.CGColor;
    uploadImage.layer.borderWidth = 2;
    uploadImage.layer.cornerRadius = 5;
    
    skipButton.layer.borderColor = LIGHT_BEIGE.CGColor;
    skipButton.layer.borderWidth = 2;
    skipButton.layer.cornerRadius = 5;
    
    checkBox.selected = YES;
    checkBox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checked.png"]];
    
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    
//    activityIndicator.center = self.view.center;
//    [activityIndicator startAnimating];
//    [self.view addSubview:activityIndicator];
//    activityIndicator.hidden = YES;
    
    if (_registrationInfo != nil)
    {
        [self editAccount:_registrationInfo];
    }
}

-(void) editAccount: (RegistrationInfo *) registrationInfo
{
    firstName.text = registrationInfo.firstName;
    middleName.text = registrationInfo.middleName;
    lastName.text = registrationInfo.lastName;
    motherName.text = registrationInfo.motherName;
    motherLastName.text = registrationInfo.motherLastName;
    sex.text = registrationInfo.gender;
    phoneNumber.text = registrationInfo.mobileNumber;
    email.text = registrationInfo.emailAddress;
    job.text = registrationInfo.job;
    bloodType.text = registrationInfo.bloodType;
    if ([registrationInfo.canDonate isEqualToString:@"NO"])
    {
        checkBox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Unchecked.png"]];
    }
    else
    {
        checkBox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checked.png"]];
    }
    address.text = registrationInfo.address;
    hometown.text = registrationInfo.hometown;
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //TODO: uploadImageToServer:chosenImage
    //UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //[self uploadImageToServer:chosenImage];
    
    [uploadImage setTitle:@"Edit Image ..." forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) uploadImageToServer1 :(UIImage *)chosenImage
{
    NSURL *url = [NSURL URLWithString:@"http://atallahmaronite.com/images/AppMembers/test.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [request setHTTPMethod:@"POST"];
    NSString *boundaryConstant = [NSString stringWithFormat:@"----------V2ymHFg03ehbqgZCaKO6jy"];
    NSString *contentTypeValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request addValue:contentTypeValue forHTTPHeaderField:@"Content-type"];
    
    NSMutableData *dataForm = [NSMutableData alloc];
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"param1\";\r\n\r\n%@", @"10001"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@.png\"\r\n", @"test"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[NSData dataWithData:imageData]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:dataForm];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:dataForm];
    [uploadTask resume];
}
- (void) uploadImageToServer:(UIImage *)chosenImage
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://atallahmaronite.com/api/users/postimage"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [request setHTTPMethod:@"POST"];
    NSString *boundaryConstant = [NSString stringWithFormat:@"----------V2ymHFg03ehbqgZCaKO6jy"];
    NSString *contentTypeValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request addValue:contentTypeValue forHTTPHeaderField:@"Content-type"];
    
    NSMutableData *dataForm = [NSMutableData alloc];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@.png\"\r\n", @"test"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[NSData dataWithData:imageData]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:dataForm];
    
    NSURLSessionDataTask *postDataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", string);
    }];
    
    [postDataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"Sent %lld, Total sent %lld, Not Sent %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    receiveData = [NSMutableData data];
    [receiveData setLength:0];
    completionHandler(NSURLSessionResponseAllow);
    NSLog(@"NSURLSession Starts to Receive Data");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [receiveData appendData:data];
    NSLog(@"NSURLSession Receive Data");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"URL Session Complete: %@", task.response.description);
    
    if(error != nil) {
        NSLog(@"Error %@",[error userInfo]);
    } else {
        NSLog(@"Uploading is Succesfull");
        
        NSString *result = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)resetPlaceHoldersForText
{
    [firstName setPlaceholder:@"First Name *"];
    
    [middleName setPlaceholder:@"Middle Name *"];
    
    [lastName setPlaceholder:@"Last Name *"];
    
    [motherName setPlaceholder:@"Mother Name *"];
    
    [motherLastName setPlaceholder:@"Mother Last Name *"];
    
    [sex setPlaceholder:@"Gender *"];
    
    [phoneNumber setPlaceholder:@"Mobile Number *"];
    
    [email setPlaceholder:@"Email Address"];
    
    [job setPlaceholder:@"Job *"];
    
    [bloodType setPlaceholder:@"Blood Type *"];
    
    [address setPlaceholder:@"Address *"];
    
    [hometown setPlaceholder:@"Hometown *"];
}

-(IBAction)editObjectImage:(id)sender
{
    UIButton *theButton = (UIButton*)sender;
    if (theButton.selected)
    {
        theButton.selected = NO;
        theButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Unchecked.png"]];
    }
    else
    {
        theButton.selected = YES;
        theButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checked.png"]];
    }
}

-(void) setTextWitoutAutocapitalization:(UITextField *)theTextField
{
    [self setTextFieldStyle:theTextField];
    theTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
}

-(void) setTextFieldStyle:(UITextField *)theTextField
{
    [theTextField setReturnKeyType:UIReturnKeyDone];
    theTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = LIGHT_BEIGE.CGColor;
    border.frame = CGRectMake(0, theTextField.frame.size.height - borderWidth, theTextField.frame.size.width, theTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [theTextField.layer addSublayer:border];
    theTextField.layer.masksToBounds = YES;
    theTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self registerForKeyboardNotifications];
}

#pragma mark - scrolling

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 64, 0.0);
    self.scrollerView.contentInset = contentInsets;
    self.scrollerView.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollerView.contentInset = contentInsets;
    self.scrollerView.scrollIndicatorInsets = contentInsets;
}

+(NSMutableArray *) getGenderList
{
    NSMutableArray* genderList = [[NSMutableArray alloc] init];
    [genderList addObject:@"Female"];
    [genderList addObject:@"Male"];
    return genderList;
}

+(NSMutableArray *) getbloodTypeList
{
    NSMutableArray* bloodTypes = [[NSMutableArray alloc] init];
    [bloodTypes addObject:@"O+"];
    [bloodTypes addObject:@"O-"];
    [bloodTypes addObject:@"A+"];
    [bloodTypes addObject:@"A–"];
    [bloodTypes addObject:@"B+"];
    [bloodTypes addObject:@"B–"];
    [bloodTypes addObject:@"AB+"];
    [bloodTypes addObject:@"AB–"];
    return bloodTypes;
}

+(NSMutableArray *) getJobsList
{
    NSMutableArray* jobList = [[NSMutableArray alloc] init];
    [jobList addObject:@"Account Collector"];
    [jobList addObject:@"Accountant"];
    [jobList addObject:@"Actor"];
    [jobList addObject:@"Administrative Assistant"];
    [jobList addObject:@"Architect"];
    [jobList addObject:@"Art Director"];
    [jobList addObject:@"Biomedical Engineer"];
    [jobList addObject:@"Cargo and Freight Agent"];
    [jobList addObject:@"Carpenter"];
    [jobList addObject:@"Chauffeur"];
    [jobList addObject:@"Computer Programmer"];
    [jobList addObject:@"Computer Software Engineer"];
    [jobList addObject:@"Computer System Analyst"];
    [jobList addObject:@"Construction Inspector"];
    [jobList addObject:@"Construction Manager"];
    [jobList addObject:@"Customer Service Representative"];
    [jobList addObject:@"Dancer"];
    [jobList addObject:@"Doctor"];
    [jobList addObject:@"Economist"];
    [jobList addObject:@"Electrical and Electronics Engineer"];
    [jobList addObject:@"Electro-mechanical Technician"];
    [jobList addObject:@"Engineering Manager"];
    [jobList addObject:@"Fabricator"];
    [jobList addObject:@"Financial Manager"];
    [jobList addObject:@"Hairdresser"];
    [jobList addObject:@"Humain Resources Manager"];
    [jobList addObject:@"Humain Resources specialist"];
    [jobList addObject:@"Interior Designer"];
    [jobList addObject:@"It Consultant"];
    [jobList addObject:@"Kindergarten Teacher"];
    [jobList addObject:@"Lawyer"];
    [jobList addObject:@"Lifeguard and Other Recreational"];
    [jobList addObject:@"Management Analyst"];
    [jobList addObject:@"Mechanical Engineer"];
    [jobList addObject:@"Mechanic-Automotive"];
    [jobList addObject:@"Other"];
    [jobList addObject:@"Painter"];
    [jobList addObject:@"MPhotographer"];
    [jobList addObject:@"Physician"];
    [jobList addObject:@"Political Scientist"];
    [jobList addObject:@"Production Manager"];
    [jobList addObject:@"Purchasing Manager and Agent"];
    [jobList addObject:@"Real Estate Manager"];
    [jobList addObject:@"Receptionist"];
    [jobList addObject:@"Sound Engineering Technician"];
    [jobList addObject:@"Student"];
    [jobList addObject:@"Travel Agent"];
    [jobList addObject:@"Production Manager"];
    return jobList;
}

-(BOOL) verifyRequiredFields
{
    BOOL verified = YES;
    if ([firstName.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"First Name *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        firstName.attributedPlaceholder = str;
        verified = NO;
    }
    if ([middleName.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Middle Name *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        middleName.attributedPlaceholder = str;
        verified = NO;
    }
    if ([lastName.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Last Name *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        lastName.attributedPlaceholder = str;
        verified = NO;
    }
    if ([motherName.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Mother Name *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        motherName.attributedPlaceholder = str;
        verified = NO;
    }
    if ([motherLastName.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Mother Last Name *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        motherLastName.attributedPlaceholder = str;
        verified = NO;
    }
    if ([sex.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Gender *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        sex.attributedPlaceholder = str;
        verified = NO;
    }
    if ([phoneNumber.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Mobile Number *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        phoneNumber.attributedPlaceholder = str;
        verified = NO;
    }
    if ([job.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Job *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        job.attributedPlaceholder = str;
        verified = NO;
    }
    if ([bloodType.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Blood Type *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        bloodType.attributedPlaceholder = str;
        verified = NO;
    }
    if ([address.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Address *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        address.attributedPlaceholder = str;
        verified = NO;
    }
    if ([hometown.text isEqualToString:@""])
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Hometown *" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        hometown.attributedPlaceholder = str;
        verified = NO;
    }

    return verified;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    activityIndicator.hidden = NO;
    if ([segue.identifier isEqualToString:@"createAccount"])
    {
        if (isEditingMode)
        {
            [self editAccount];
        }
        else
        {
            [self createAccount];
        }
    }
    destinationView = segue.destinationViewController;
    MainViewController *controller = (MainViewController *)destinationView.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
}

-(void) editAccount
{
    [self deleteExistingData];
    [self saveRegistrationInfo];
}

-(void)createAccount
{
    [self postDataToServer];
    [myCondition lock];
    while (!postDataIsDone)
        [myCondition wait];
    
    [self deleteExistingData];
    [self saveRegistrationInfo];
    [myCondition unlock];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"createAccount"])
    {
        BOOL goNext = [self verifyRequiredFields];
        if (goNext)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"isRegistered"];
            
            fullName = [NSString stringWithFormat:@"%@ %@ %@", firstName.text, middleName.text, lastName.text];
            [Answers logCustomEventWithName:fullName customAttributes:nil];
        }
        return goNext;
    }
    else
    {
        return YES;
    }
}

-(void) deleteExistingData
{
    NSManagedObjectContext *objectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RegistrationInfo" inManagedObjectContext:objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSError *error;
    [request setEntity:entity];
    
    NSMutableArray *results = [[objectContext executeFetchRequest:request error:&error]mutableCopy];
    
    for (NSManagedObject *obj in results)
    {
        [objectContext deleteObject:obj];
    }
    [objectContext save:&error];
    
}

-(void) saveRegistrationInfo
{
    RegistrationInfo *member = [NSEntityDescription insertNewObjectForEntityForName:@"RegistrationInfo" inManagedObjectContext:[self managedObjectContext]];
    member.firstName= firstName.text;
    member.middleName= middleName.text;
    member.lastName= lastName.text;
    member.motherName= motherName.text;
    member.motherLastName= motherLastName.text;
    member.gender= sex.text;
    member.mobileNumber= phoneNumber.text;
    member.emailAddress= email.text;
    member.job= job.text;
    member.bloodType= bloodType.text;
    member.canDonate= checkBox.selected ? @"YES" : @"NO";
    member.address= address.text;
    member.hometown= hometown.text;
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

-(void)postDataToServer
{
    [myCondition lock];

    //TODO: fix the blood type that is being saved with "?" mark in sql server db
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://atallahmaronite.com/api/users/postperson"]];
    [req setHTTPMethod:@"POST"];
    NSString *lastNameText = lastName.text;
    NSString *firstNameText = firstName.text;
    NSString *middleNameText = middleName.text;
    NSString *motherNameText = motherName.text;
    NSString *motherLastNameText = motherLastName.text;
    NSString *sexText = sex.text;
    NSString *phoneNumberText = phoneNumber.text;
    NSString *emailText = email.text;
    NSString *jobText = job.text;
    NSString *bloodTypeText = bloodType.text;
    NSString *canDonateText = checkBox.selected ? @"YES" : @"NO";
    NSString *addressText = address.text;
    NSString *hometownText = hometown.text;
    NSString *deviceID = [AppDelegate getDeviceUUID];
    NSDictionary *dictionary = @{@"LastName":lastNameText, @"MiddleName":middleNameText, @"FirstName":firstNameText, @"MotherName":motherNameText, @"MotherLastName":motherLastNameText, @"Gender":sexText, @"MobileNumber":phoneNumberText, @"EmailAddress":emailText, @"Job":jobText, @"BloodType":bloodTypeText, @"CanDonate":canDonateText, @"Address":addressText, @"Hometown":hometownText, @"DeviceID":deviceID};
    NSError *err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * string = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    
    NSData *postData = [string dataUsingEncoding:NSASCIIStringEncoding];

    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [req addValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                            {
                                                //TODO: fix registration with no wifi(handle error code)
                                                NSString *dataReturned = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                NSLog(@"postDataToServer returned data: %@", dataReturned);
                                                if (error != nil)
                                                {
                                                    NSInteger status = [error code];
                                                    dataReturned = [NSString stringWithFormat:@"%ld", (long)status];
                                                    NSLog(@"postDataToServer returned error code: %@", dataReturned);
                                                }
                                                [Answers logCustomEventWithName:fullName customAttributes:@{@"Post Returned Status":dataReturned}];
                                                
                                                postDataIsDone = YES;
                                                [myCondition signal];
                                                [myCondition unlock];
                                                
                                                //TODO: add activityIndicator
//                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    NSLog(@"stopAnimating");
//                                                    [activityIndicator stopAnimating];
//                                                });
                                            }];
    
    [task resume];
    
}

@end
