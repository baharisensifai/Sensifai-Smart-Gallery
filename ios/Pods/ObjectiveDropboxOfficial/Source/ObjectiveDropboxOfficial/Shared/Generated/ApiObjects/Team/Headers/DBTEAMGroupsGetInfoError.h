///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMGroupsGetInfoError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `GroupsGetInfoError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMGroupsGetInfoError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMGroupsGetInfoErrorTag` enum type represents the possible tag
/// states with which the `DBTEAMGroupsGetInfoError` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMGroupsGetInfoErrorTag){
    /// The group is not on your team.
    DBTEAMGroupsGetInfoErrorGroupNotOnTeam,

    /// (no description).
    DBTEAMGroupsGetInfoErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMGroupsGetInfoErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "group_not_on_team".
///
/// Description of the "group_not_on_team" tag state: The group is not on your
/// team.
///
/// @return An initialized instance.
///
- (instancetype)initWithGroupNotOnTeam;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value
/// "group_not_on_team".
///
/// @return Whether the union's current tag state has value "group_not_on_team".
///
- (BOOL)isGroupNotOnTeam;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBTEAMGroupsGetInfoError` union.
///
@interface DBTEAMGroupsGetInfoErrorSerializer : NSObject

///
/// Serializes `DBTEAMGroupsGetInfoError` instances.
///
/// @param instance An instance of the `DBTEAMGroupsGetInfoError` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMGroupsGetInfoError` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMGroupsGetInfoError *)instance;

///
/// Deserializes `DBTEAMGroupsGetInfoError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMGroupsGetInfoError` API object.
///
/// @return An instantiation of the `DBTEAMGroupsGetInfoError` object.
///
+ (DBTEAMGroupsGetInfoError *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
