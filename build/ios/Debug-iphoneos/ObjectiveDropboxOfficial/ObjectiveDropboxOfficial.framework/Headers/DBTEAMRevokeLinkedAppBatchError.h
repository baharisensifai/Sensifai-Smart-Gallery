///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMRevokeLinkedAppBatchError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `RevokeLinkedAppBatchError` union.
///
/// Error returned by `linkedAppsRevokeLinkedAppBatch`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMRevokeLinkedAppBatchError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMRevokeLinkedAppBatchErrorTag` enum type represents the possible
/// tag states with which the `DBTEAMRevokeLinkedAppBatchError` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMRevokeLinkedAppBatchErrorTag){
    /// (no description).
    DBTEAMRevokeLinkedAppBatchErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMRevokeLinkedAppBatchErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

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
/// The serialization class for the `DBTEAMRevokeLinkedAppBatchError` union.
///
@interface DBTEAMRevokeLinkedAppBatchErrorSerializer : NSObject

///
/// Serializes `DBTEAMRevokeLinkedAppBatchError` instances.
///
/// @param instance An instance of the `DBTEAMRevokeLinkedAppBatchError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMRevokeLinkedAppBatchError` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMRevokeLinkedAppBatchError *)instance;

///
/// Deserializes `DBTEAMRevokeLinkedAppBatchError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMRevokeLinkedAppBatchError` API object.
///
/// @return An instantiation of the `DBTEAMRevokeLinkedAppBatchError` object.
///
+ (DBTEAMRevokeLinkedAppBatchError *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
