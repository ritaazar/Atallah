//
//  TypesViewController.m
//  AttalahMaronite
//
//  Created by Azar, Rita on 4/23/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "TypesViewController.h"
#import "TypesTableViewCell.h"
#import "CommonMacros.h"
#import <CoreData/CoreData.h>
#import "MemberViewController.h"
#import "Member.h"

@interface TypesViewController ()

@end

@implementation TypesViewController

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
    return [self.typesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TypesTableViewCell *cell = (TypesTableViewCell *)[tableView
                                      dequeueReusableCellWithIdentifier:@"TypesTableViewCell"];
    cell.typeTitle.text = [self.typesList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MemberViewController *destinationView = segue.destinationViewController;
    
    if ([_barTitle isEqualToString:@"Jobs List"])
    {
        NSString *jobType = [_typesList objectAtIndex:_listTableView.indexPathForSelectedRow.row];
        destinationView.membersList = [self fetchMembersListWithJobType:jobType];
    }
    else if ([_barTitle isEqualToString:@"Blood Types List"])
    {
        NSString *bloodType = [_typesList objectAtIndex:_listTableView.indexPathForSelectedRow.row];
        destinationView.membersList = [self fetchMembersListWithBloodType:bloodType];
    }
}

-(NSMutableArray *) fetchMembersListWithJobType: (NSString *) type
{
    NSManagedObjectContext *moc = [self managedObjectContext];;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Member"];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"job == %@", type]];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    return [results mutableCopy];
}

-(NSMutableArray *) fetchMembersListWithBloodType: (NSString *) type
{
    NSManagedObjectContext *moc = [self managedObjectContext];;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Member"];
    
    NSLog(@"%@", type);
    [request setPredicate:[NSPredicate predicateWithFormat:@"bloodType == %@", type]];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    return [results mutableCopy];
}

@end
