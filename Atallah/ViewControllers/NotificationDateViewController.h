//
//  NotificationDateViewController.h
//  AttalahMaronite
//
//  Created by Azar, Rita on 4/23/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDateViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSMutableArray *datesList;
@property (strong, nonatomic) NSString *barTitle;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
