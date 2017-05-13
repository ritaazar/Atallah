//
//  MemberViewController.h
//  AttalahMaronite
//
//  Created by Azar, Rita on 5/29/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *membersTableView;
@property (strong, nonatomic) NSMutableArray *membersList;


@end
