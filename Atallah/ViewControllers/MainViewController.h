//
//  MainViewController.h
//  AttalahMaronite
//
//  Created by Azar, Rita on 4/18/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    NSString *fullName;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (assign, nonatomic) BOOL postingDataIsDone;

@end
