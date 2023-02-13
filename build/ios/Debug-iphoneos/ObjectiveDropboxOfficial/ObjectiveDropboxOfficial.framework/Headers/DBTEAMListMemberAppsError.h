///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMListMemberAppsError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ListMemberAppsError` union.
///
/// Error returned by `linkedAppsListMemberLinkedApps`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMListMemberAppsError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMListMemberAppsErrorTag` enum type represents the possible tag
/// states with which the `DBTEAMListMemberAppsError` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMListMemberAppsErrorTag){
    /// Member not found.
    DBTEAMListMemberAppsErrorMemberNotFound,

    /// (no description).
    DBTEAMListMemberAppsErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMListMemberAppsErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "member_not_found".
///
/// Description of the "member_not_found" tag state: Member not found.
///
/// @return An initialized instance.
///
- (instancetype)initWithMemberNotFound;

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
/// "member_not_found".
///
/// @return Whether the union's current tag state has value "member_not_found".
///
- (BOOL)isMemberNotFound;

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
/// The serialization class for the `DBTEAMListMemberAppsError` union.
///
@interface DBTEAMListMemberAppsErrorSerializer : NSObject

///
/// Serializes `DBTEAMListMemberAppsError` instances.
///
/// @param instance An instance of the `DBTEAMListMemberAppsError` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMListMemberAppsError` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMListMemberAppsError *)instance;

///
/// Deserializes `DBTEAMListMemberAppsError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMListMemberAppsError` API object.
///
/// @return An instantiation of the `DBTEAMListMemberAppsError` object.
///
+ (DBTEAMListMemberAppsError *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
