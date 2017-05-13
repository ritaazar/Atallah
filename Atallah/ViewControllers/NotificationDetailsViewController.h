//
//  NotificationDetailsViewController.h
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/2/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationInfo+CoreDataProperties.h"

@interface NotificationDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *notificationText;
@property (strong, nonatomic) NSString *notificationDate;
@property (strong, nonatomic) IBOutlet UITextView *dateTextView;
@property (strong, nonatomic) IBOutlet UITextView *notificationTextView;

@end
