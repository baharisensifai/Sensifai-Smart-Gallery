///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGSharedContentAddLinkExpiryDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SharedContentAddLinkExpiryDetails` struct.
///
/// Added expiration date to link for shared file/folder.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSharedContentAddLinkExpiryDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// New shared content link expiration date. Might be missing due to historical
/// data gap.
@property (nonatomic, readonly, nullable) NSDate *dNewValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewValue New shared content link expiration date. Might be missing
/// due to historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(nullable NSDate *)dNewValue;

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
/// The serialization class for the `SharedContentAddLinkExpiryDetails` struct.
///
@interface DBTEAMLOGSharedContentAddLinkExpiryDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGSharedContentAddLinkExpiryDetails` instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGSharedContentAddLinkExpiryDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedContentAddLinkExpiryDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGSharedContentAddLinkExpiryDetails *)instance;

///
/// Deserializes `DBTEAMLOGSharedContentAddLinkExpiryDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedContentAddLinkExpiryDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGSharedContentAddLinkExpiryDetails`
/// object.
///
+ (DBTEAMLOGSharedContentAddLinkExpiryDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
