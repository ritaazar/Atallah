//
//  MemberTableViewCell.h
//  AttalahMaronite
//
//  Created by Azar, Rita on 5/29/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *imageViewMember;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@end
