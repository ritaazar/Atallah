//
//  RegistrationInfo+CoreDataProperties.m
//  
//
//  Created by Rita Azar on 6/28/17.
//
//

#import "RegistrationInfo+CoreDataProperties.h"

@implementation RegistrationInfo (CoreDataProperties)

+ (NSFetchRequest<RegistrationInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RegistrationInfo"];
}

@dynamic address;
@dynamic bloodType;
@dynamic canDonate;
@dynamic deviceID;
@dynamic emailAddress;
@dynamic firstName;
@dynamic gender;
@dynamic hometown;
@dynamic job;
@dynamic lastName;
@dynamic middleName;
@dynamic mobileNumber;
@dynamic motherLastName;
@dynamic motherName;
@dynamic personId;

@end
