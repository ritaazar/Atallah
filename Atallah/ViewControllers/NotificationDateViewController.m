//
//  NotificationDateViewController.m
//  AttalahMaronite
//
//  Created by Azar, Rita on 4/23/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "NotificationDateViewController.h"
#import "TypesTableViewCell.h"
#import "CommonMacros.h"
#import <CoreData/CoreData.h>
#import "NotificationDetailsViewController.h"
#import "Member.h"
#import "NotificationInfo+CoreDataProperties.h"

@implementation NotificationDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
}

- (void) initNavigation
{
    _listTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [self.navigationController.navigationBar setBarTintColor:DARK_BEIGE];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]}];
    self.navigationItem.title = _barTitle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.datesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TypesTableViewCell *cell = (TypesTableViewCell *)[tableView
                                      dequeueReusableCellWithIdentifier:@"TypesTableViewCell"];
    cell.typeTitle.text = [self.datesList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NotificationDetailsViewController *destinationView = segue.destinationViewController;
    NSString *date = [_datesList objectAtIndex:_listTableView.indexPathForSelectedRow.row];
    destinationView.notificationDate = date;
    destinationView.notificationText = [self fetchNotificationWithDate:date];
}

-(NSString *) fetchNotificationWithDate: (NSString *) date
{
    NSManagedObjectContext *moc = [self managedObjectContext];;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NotificationInfo"];
    request.fetchLimit = 1;
    [request setPredicate:[NSPredicate predicateWithFormat:@"date == %@", date]];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    NotificationInfo *notificationInfo = results.firstObject;
    NSString *notificationText = notificationInfo.text;
    return notificationText;
}

@end
