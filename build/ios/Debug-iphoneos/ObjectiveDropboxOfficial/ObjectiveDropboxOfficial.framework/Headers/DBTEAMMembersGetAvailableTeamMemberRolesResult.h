///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMMembersGetAvailableTeamMemberRolesResult;
@class DBTEAMTeamMemberRole;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MembersGetAvailableTeamMemberRolesResult` struct.
///
/// Available TeamMemberRole for the connected team. To be used with
/// `membersSetAdminPermissions`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMMembersGetAvailableTeamMemberRolesResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Available roles.
@property (nonatomic, readonly) NSArray<DBTEAMTeamMemberRole *> *roles;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param roles Available roles.
///
/// @return An initialized instance.
///
- (instancetype)initWithRoles:(NSArray<DBTEAMTeamMemberRole *> *)roles;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `MembersGetAvailableTeamMemberRolesResult`
/// struct.
///
@interface DBTEAMMembersGetAvailableTeamMemberRolesResultSerializer : NSObject

///
/// Serializes `DBTEAMMembersGetAvailableTeamMemberRolesResult` instances.
///
/// @param instance An instance of the
/// `DBTEAMMembersGetAvailableTeamMemberRolesResult` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMMembersGetAvailableTeamMemberRolesResult` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMMembersGetAvailableTeamMemberRolesResult *)instance;

///
/// Deserializes `DBTEAMMembersGetAvailableTeamMemberRolesResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMMembersGetAvailableTeamMemberRolesResult` API object.
///
/// @return An instantiation of the
/// `DBTEAMMembersGetAvailableTeamMemberRolesResult` object.
///
+ (DBTEAMMembersGetAvailableTeamMemberRolesResult *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END