//
//  RegistrationInfo+CoreDataProperties.h
//  
//
//  Created by Rita Azar on 6/28/17.
//
//

#import "RegistrationInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RegistrationInfo (CoreDataProperties)

+ (NSFetchRequest<RegistrationInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *bloodType;
@property (nullable, nonatomic, copy) NSString *canDonate;
@property (nullable, nonatomic, copy) NSString *deviceID;
@property (nullable, nonatomic, copy) NSString *emailAddress;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *hometown;
@property (nullable, nonatomic, copy) NSString *job;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *middleName;
@property (nullable, nonatomic, copy) NSString *mobileNumber;
@property (nullable, nonatomic, copy) NSString *motherLastName;
@property (nullable, nonatomic, copy) NSString *motherName;
@property (nullable, nonatomic, copy) NSNumber *personId;

@end

NS_ASSUME_NONNULL_END
