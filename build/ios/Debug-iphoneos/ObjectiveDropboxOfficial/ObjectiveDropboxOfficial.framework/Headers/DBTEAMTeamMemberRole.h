///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMTeamMemberRole;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `TeamMemberRole` struct.
///
/// A role which can be attached to a team member. This replaces AdminTier; each
/// AdminTier corresponds to a new TeamMemberRole with a matching name.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMTeamMemberRole : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// A string containing encoded role ID. For roles defined by Dropbox, this is
/// the same across all teams.
@property (nonatomic, readonly, copy) NSString *roleId;

/// The role display name.
@property (nonatomic, readonly, copy) NSString *name;

/// Role description. Describes which permissions come with this role.
@property (nonatomic, readonly, copy) NSString *description_;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param roleId A string containing encoded role ID. For roles defined by
/// Dropbox, this is the same across all teams.
/// @param name The role display name.
/// @param description_ Role description. Describes which permissions come with
/// this role.
///
/// @return An initialized instance.
///
- (instancetype)initWithRoleId:(NSString *)roleId name:(NSString *)name description_:(NSString *)description_;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `TeamMemberRole` struct.
///
@interface DBTEAMTeamMemberRoleSerializer : NSObject

///
/// Serializes `DBTEAMTeamMemberRole` instances.
///
/// @param instance An instance of the `DBTEAMTeamMemberRole` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMTeamMemberRole` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMTeamMemberRole *)instance;

///
/// Deserializes `DBTEAMTeamMemberRole` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMTeamMemberRole` API object.
///
/// @return An instantiation of the `DBTEAMTeamMemberRole` object.
///
+ (DBTEAMTeamMemberRole *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
