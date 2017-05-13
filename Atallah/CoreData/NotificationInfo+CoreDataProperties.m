//
//  NotificationInfo+CoreDataProperties.m
//  
//
//  Created by Azar, Rita on 12/17/16.
//
//

#import "NotificationInfo+CoreDataProperties.h"

@implementation NotificationInfo (CoreDataProperties)

+ (NSFetchRequest<NotificationInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NotificationInfo"];
}

@dynamic id;
@dynamic date;
@dynamic text;

@end
