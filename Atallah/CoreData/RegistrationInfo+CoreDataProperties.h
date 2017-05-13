//
//  RegistrationInfo+CoreDataProperties.h
//  AtallahMaronite
//
//  Created by Azar, Rita on 6/2/16.
//  Copyright © 2016 Azar, Rita. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RegistrationInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegistrationInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *bloodType;
@property (nullable, nonatomic, retain) NSString *canDonate;
@property (nullable, nonatomic, retain) NSString *deviceID;
@property (nullable, nonatomic, retain) NSString *emailAddress;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *hometown;
@property (nullable, nonatomic, retain) NSString *job;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *middleName;
@property (nullable, nonatomic, retain) NSString *mobileNumber;
@property (nullable, nonatomic, retain) NSString *motherLastName;
@property (nullable, nonatomic, retain) NSString *motherName;

@end

NS_ASSUME_NONNULL_END
