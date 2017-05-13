//
//  NotificationInfo+CoreDataProperties.h
//  
//
//  Created by Azar, Rita on 12/17/16.
//
//

#import "NotificationInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NotificationInfo (CoreDataProperties)

+ (NSFetchRequest<NotificationInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
