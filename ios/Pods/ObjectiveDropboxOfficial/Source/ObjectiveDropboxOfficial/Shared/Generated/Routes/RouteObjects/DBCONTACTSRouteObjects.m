///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBCONTACTSRouteObjects.h"
#import "DBCONTACTSDeleteManualContactsError.h"
#import "DBCONTACTSUserAuthRoutes.h"
#import "DBRequestErrors.h"
#import "DBStoneBase.h"

@implementation DBCONTACTSRouteObjects

static DBRoute *DBCONTACTSDeleteManualContacts;
static DBRoute *DBCONTACTSDeleteManualContactsBatch;

static NSObject *lockObj = nil;
+ (void)initialize {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    lockObj = [[NSObject alloc] init];
  });
}

+ (DBRoute *)DBCONTACTSDeleteManualContacts {
  @synchronized(lockObj) {
    if (!DBCONTACTSDeleteManualContacts) {
      DBCONTACTSDeleteManualContacts = [[DBRoute alloc] init:@"delete_manual_contacts"
                                                  namespace_:@"contacts"
                                                  deprecated:@NO
                                                  resultType:nil
                                                   errorType:nil
                                                       attrs:@{
                                                         @"auth" : @"user",
                                                         @"host" : @"api",
                                                         @"style" : @"rpc"
                                                       }
                                       dataStructSerialBlock:nil
                                     dataStructDeserialBlock:nil];
    }
    return DBCONTACTSDeleteManualContacts;
  }
}

+ (DBRoute *)DBCONTACTSDeleteManualContactsBatch {
  @synchronized(lockObj) {
    if (!DBCONTACTSDeleteManualContactsBatch) {
      DBCONTACTSDeleteManualContactsBatch = [[DBRoute alloc] init:@"delete_manual_contacts_batch"
                                                       namespace_:@"contacts"
                                                       deprecated:@NO
                                                       resultType:nil
                                                        errorType:[DBCONTACTSDeleteManualContactsError class]
                                                            attrs:@{
                                                              @"auth" : @"user",
                                                              @"host" : @"api",
                                                              @"style" : @"rpc"
                                                            }
                                            dataStructSerialBlock:nil
                                          dataStructDeserialBlock:nil];
    }
    return DBCONTACTSDeleteManualContactsBatch;
  }
}

@end
