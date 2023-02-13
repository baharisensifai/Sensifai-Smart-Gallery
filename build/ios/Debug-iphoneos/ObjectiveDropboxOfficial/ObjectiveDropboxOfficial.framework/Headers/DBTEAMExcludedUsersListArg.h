///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMExcludedUsersListArg;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ExcludedUsersListArg` struct.
///
/// Excluded users list argument.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMExcludedUsersListArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Number of results to return per call.
@property (nonatomic, readonly) NSNumber *limit;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param limit Number of results to return per call.
///
/// @return An initialized instance.
///
- (instancetype)initWithLimit:(nullable NSNumber *)limit;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ExcludedUsersListArg` struct.
///
@interface DBTEAMExcludedUsersListArgSerializer : NSObject

///
/// Serializes `DBTEAMExcludedUsersListArg` instances.
///
/// @param instance An instance of the `DBTEAMExcludedUsersListArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMExcludedUsersListArg` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMExcludedUsersListArg *)instance;

///
/// Deserializes `DBTEAMExcludedUsersListArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMExcludedUsersListArg` API object.
///
/// @return An instantiation of the `DBTEAMExcludedUsersListArg` object.
///
+ (DBTEAMExcludedUsersListArg *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
