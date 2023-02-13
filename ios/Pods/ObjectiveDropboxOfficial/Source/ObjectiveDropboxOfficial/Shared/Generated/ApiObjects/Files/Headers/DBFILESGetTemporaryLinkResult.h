///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESFileMetadata;
@class DBFILESGetTemporaryLinkResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `GetTemporaryLinkResult` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESGetTemporaryLinkResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Metadata of the file.
@property (nonatomic, readonly) DBFILESFileMetadata *metadata;

/// The temporary link which can be used to stream content the file.
@property (nonatomic, readonly, copy) NSString *link;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param metadata Metadata of the file.
/// @param link The temporary link which can be used to stream content the file.
///
/// @return An initialized instance.
///
- (instancetype)initWithMetadata:(DBFILESFileMetadata *)metadata link:(NSString *)link;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `GetTemporaryLinkResult` struct.
///
@interface DBFILESGetTemporaryLinkResultSerializer : NSObject

///
/// Serializes `DBFILESGetTemporaryLinkResult` instances.
///
/// @param instance An instance of the `DBFILESGetTemporaryLinkResult` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESGetTemporaryLinkResult` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILESGetTemporaryLinkResult *)instance;

///
/// Deserializes `DBFILESGetTemporaryLinkResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESGetTemporaryLinkResult` API object.
///
/// @return An instantiation of the `DBFILESGetTemporaryLinkResult` object.
///
+ (DBFILESGetTemporaryLinkResult *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
