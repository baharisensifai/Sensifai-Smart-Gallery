///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGDesktopDeviceSessionLogInfo;
@class DBTEAMLOGExternalDriveBackupEligibilityStatus;
@class DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ExternalDriveBackupEligibilityStatusCheckedDetails` struct.
///
/// Checked external drive backup eligibility status.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Device's session logged information.
@property (nonatomic, readonly) DBTEAMLOGDesktopDeviceSessionLogInfo *desktopDeviceSessionInfo;

/// Current eligibility status of external drive backup.
@property (nonatomic, readonly) DBTEAMLOGExternalDriveBackupEligibilityStatus *status;

/// Total number of valid external drive backup for all the team members.
@property (nonatomic, readonly) NSNumber *numberOfExternalDriveBackup;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param desktopDeviceSessionInfo Device's session logged information.
/// @param status Current eligibility status of external drive backup.
/// @param numberOfExternalDriveBackup Total number of valid external drive
/// backup for all the team members.
///
/// @return An initialized instance.
///
- (instancetype)initWithDesktopDeviceSessionInfo:(DBTEAMLOGDesktopDeviceSessionLogInfo *)desktopDeviceSessionInfo
                                          status:(DBTEAMLOGExternalDriveBackupEligibilityStatus *)status
                     numberOfExternalDriveBackup:(NSNumber *)numberOfExternalDriveBackup;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the
/// `ExternalDriveBackupEligibilityStatusCheckedDetails` struct.
///
@interface DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails`
/// instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:
    (DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails *)instance;

///
/// Deserializes `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails`
/// instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails` object.
///
+ (DBTEAMLOGExternalDriveBackupEligibilityStatusCheckedDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
