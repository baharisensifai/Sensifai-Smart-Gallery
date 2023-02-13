///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMTeamNamespacesListError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `TeamNamespacesListError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMTeamNamespacesListError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMTeamNamespacesListErrorTag` enum type represents the possible tag
/// states with which the `DBTEAMTeamNamespacesListError` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMTeamNamespacesListErrorTag){
    /// Argument passed in is invalid.
    DBTEAMTeamNamespacesListErrorInvalidArg,

    /// (no description).
    DBTEAMTeamNamespacesListErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMTeamNamespacesListErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "invalid_arg".
///
/// Description of the "invalid_arg" tag state: Argument passed in is invalid.
///
/// @return An initialized instance.
///
- (instancetype)initWithInvalidArg;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "invalid_arg".
///
/// @return Whether the union's current tag state has value "invalid_arg".
///
- (BOOL)isInvalidArg;

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
/// The serialization class for the `DBTEAMTeamNamespacesListError` union.
///
@interface DBTEAMTeamNamespacesListErrorSerializer : NSObject

///
/// Serializes `DBTEAMTeamNamespacesListError` instances.
///
/// @param instance An instance of the `DBTEAMTeamNamespacesListError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMTeamNamespacesListError` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMTeamNamespacesListError *)instance;

///
/// Deserializes `DBTEAMTeamNamespacesListError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMTeamNamespacesListError` API object.
///
/// @return An instantiation of the `DBTEAMTeamNamespacesListError` object.
///
+ (DBTEAMTeamNamespacesListError *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
