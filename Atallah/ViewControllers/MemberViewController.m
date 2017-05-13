//
//  MemberViewController.m
//  AttalahMaronite
//
//  Created by Azar, Rita on 5/29/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberTableViewCell.h"
#import "CommonMacros.h"
#import "Member.h"
#import "DetailsViewController.h"

@implementation MemberViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
}

- (void) initNavigation
{
    _membersTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [self.navigationController.navigationBar setBarTintColor:DARK_BEIGE];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]}];
    self.navigationItem.title = @"Members List";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_membersList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MemberTableViewCell *cell = (MemberTableViewCell *)[tableView
                                                    dequeueReusableCellWithIdentifier:@"MemberTableViewCell"];
    
    Member *member = [_membersList objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed: @"download.jpeg"];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", member.firstName, member.lastName];
    cell.phoneLabel.text = member.mobileNumber;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailsViewController *destinationView = segue.destinationViewController;
    destinationView.member = [_membersList objectAtIndex:_membersTableView.indexPathForSelectedRow.row];
}
@end
