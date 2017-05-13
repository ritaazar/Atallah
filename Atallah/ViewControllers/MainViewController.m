//
//  MainViewController.m
//  AttalahMaronite
//
//  Created by Azar, Rita on 4/18/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "MainViewController.h"
#import "CommonMacros.h"
#import "TypesViewController.h"
#import "Member.h"
#import "MemberViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "RegistrationInfo.h"
#import "NotificationInfo+CoreDataProperties.h"
#import "NotificationDateViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self fetchMembersData];
    [self fetchNewsData];
}

-(void) initNavigation
{
    [self.navigationController.navigationBar setBarTintColor:DARK_BEIGE];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]}];
    self.navigationItem.title = @"Atallah Maronite";
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"Settings-50"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settingsBarItem)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithCustomView:settingsButton];
    self.navigationItem.rightBarButtonItem = flipButton;
}

-(void) settingsBarItem
{
    
}
-(void) fetchNewsData
{
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [_indicator startAnimating];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.atallahmaronite.com/api/notifications/get"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSString * string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
        if (string != nil && ![string isEqualToString:@""])
        {
            NSString *subStringLast = [string substringToIndex:[string length]-1];
            NSString *subStringFirst = [subStringLast substringFromIndex:1];
            NSString *stringWithoutSlaches = [subStringFirst stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSData *objectData = [stringWithoutSlaches dataUsingEncoding:NSUTF8StringEncoding];
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            NSLog(@"%@", json);
            [self deleteExistingNotification];
            [self parsingAndSavingNotifcation:json];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"stopAnimating");
            //[[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [_indicator stopAnimating];
        });
    }];
    
    [dataTask resume];
}

-(void) fetchMembersData
{
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [_indicator startAnimating];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://atallahmaronite.com/api/users/get"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSString * string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
        if (string != nil && ![string isEqualToString:@""])
        {
            NSString *subStringLast = [string substringToIndex:[string length]-1];
            NSString *subStringFirst = [subStringLast substringFromIndex:1];
            NSString *stringWithoutSlaches = [subStringFirst stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSData *objectData = [stringWithoutSlaches dataUsingEncoding:NSUTF8StringEncoding];
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            NSLog(@"%@", json);
            [self deleteExistingData];
            [self parsingAndSavingData:json];
        }
        RegistrationInfo *registrationInfo = [self getRegistrationInfo];
        NSString *returnedStatus = error != nil ? [NSString stringWithFormat:@"%ld", (long)error.code] : @"Success";
        if (registrationInfo != nil)
        {
            fullName = [NSString stringWithFormat:@"%@ %@ %@", registrationInfo.firstName, registrationInfo.middleName, registrationInfo.lastName];
            [Answers logCustomEventWithName:fullName customAttributes:@{@"Get Returned Status":returnedStatus}];
        }
        else
        {
            [Answers logCustomEventWithName:@"UnRegisteredUser" customAttributes:@{@"Get Returned Status":returnedStatus}];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"stopAnimating");
            //[[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [_indicator stopAnimating];
        });
    }];
    
    [dataTask resume];
}

-(RegistrationInfo *) getRegistrationInfo
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RegistrationInfo"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if ([results count] > 0) {
        RegistrationInfo *regisInfo = [results objectAtIndex:0];
        return regisInfo;
    }
    return nil;
}

-(void) deleteExistingData
{
    NSManagedObjectContext *objectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:objectContext];
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

-(void) deleteExistingNotification
{
    NSManagedObjectContext *objectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NotificationInfo" inManagedObjectContext:objectContext];
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

-(void) parsingAndSavingNotifcation:(NSDictionary *)dictionary
{
    for (NSDictionary *membersDictionary in dictionary)
    {
        NotificationInfo *notification = [NSEntityDescription insertNewObjectForEntityForName:@"NotificationInfo" inManagedObjectContext:[self managedObjectContext]];
        notification.date = [membersDictionary valueForKey:@"Date"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Date"];
        notification.text = [membersDictionary valueForKey:@"Text"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Text"];
    }
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    NSLog(@"done saving notification data");
}

-(void) parsingAndSavingData:(NSDictionary *)dictionary
{
    for (NSDictionary *membersDictionary in dictionary)
    {
        Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:[self managedObjectContext]];
        member.firstName= [membersDictionary valueForKey:@"FirstName"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"FirstName"];
        member.middleName= [membersDictionary valueForKey:@"MiddleName"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"MiddleName"];
        member.lastName= [membersDictionary valueForKey:@"LastName"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"LastName"];
        member.motherName= [membersDictionary valueForKey:@"MotherName"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"MotherName"];
        member.motherLastName= [membersDictionary valueForKey:@"MotherLastName"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"MotherLastName"];
        member.gender= [membersDictionary valueForKey:@"Gender"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Gender"];
        member.mobileNumber= [membersDictionary valueForKey:@"MobileNumber"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"MobileNumber"];
        member.emailAddress= [membersDictionary valueForKey:@"EmailAddress"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"EmailAddress"];
        member.job= [membersDictionary valueForKey:@"Job"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Job"];
        member.bloodType= [membersDictionary valueForKey:@"BloodType"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"BloodType"];
        member.canDonate= [membersDictionary valueForKey:@"CanDonate"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"CanDonate"];
        member.address= [membersDictionary valueForKey:@"Address"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Address"];
        member.hometown= [membersDictionary valueForKey:@"Hometown"] == [NSNull null] ? @"" :[membersDictionary valueForKey:@"Hometown"];
    }
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    NSLog(@"done saving data");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToJobsList"])
    {
        NSMutableArray * jobsList = [self getJobsList];
        TypesViewController *destinationView = segue.destinationViewController;
        destinationView.typesList = jobsList;
        destinationView.barTitle = @"Jobs List";
        destinationView.managedObjectContext = [self managedObjectContext];
    }
    else if ([[segue identifier] isEqualToString:@"goToDonationList"])
    {
        NSMutableArray *bloodTypeList = [self getBloodTypeList];
        TypesViewController *destinationView = segue.destinationViewController;
        destinationView.typesList = bloodTypeList;
        destinationView.barTitle = @"Blood Types List";
        destinationView.managedObjectContext = [self managedObjectContext];
    }
    else if ([[segue identifier] isEqualToString:@"goToMembersList"])
    {
        MemberViewController *destinationView = segue.destinationViewController;
        destinationView.membersList = [self fetchMembersList];
    }
    else if ([[segue identifier] isEqualToString:@"goToNotificationList"])
    {
        NSMutableArray *dateList = [self getNotificationDateList];
        NotificationDateViewController *destinationView = segue.destinationViewController;
        destinationView.datesList = dateList;
        destinationView.barTitle = @"News";
        destinationView.managedObjectContext = [self managedObjectContext];
    }
}

-(NSMutableArray *) getNotificationDateList
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NotificationInfo" inManagedObjectContext:moc];
    request.entity = entity;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"date"]];
    request.returnsDistinctResults = YES;
    request.resultType = NSDictionaryResultType;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *distincResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray *dateList = [NSMutableArray array];
    for(NSDictionary* obj in distincResults)
    {
        [dateList addObject:[obj objectForKey:@"date"]];
    }
    return dateList;
}


-(NSMutableArray *) getJobsList
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:moc];
    request.entity = entity;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"job"]];
    request.returnsDistinctResults = YES;
    request.resultType = NSDictionaryResultType;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"job" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *distincResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray *jobList = [NSMutableArray array];
    for(NSDictionary* obj in distincResults)
    {
        [jobList addObject:[obj objectForKey:@"job"]];
    }
    return jobList;
}

-(NSMutableArray *) getBloodTypeList
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:moc];
    request.entity = entity;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"bloodType"]];
    request.returnsDistinctResults = YES;
    request.resultType = NSDictionaryResultType;
    [request setPredicate:[NSPredicate predicateWithFormat:@"canDonate == %@", @"YES"]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"bloodType" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSMutableArray *distincResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray *bloodTypeList = [NSMutableArray array];
    for(NSDictionary* obj in distincResults)
    {
        [bloodTypeList addObject:[obj objectForKey:@"bloodType"]];
    }
    return bloodTypeList;
}

-(NSMutableArray *) fetchMembersList
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Member"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Member objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    return [results mutableCopy];
}

@end
