///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESMetadata;
@class DBFILESSaveCopyReferenceResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SaveCopyReferenceResult` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESSaveCopyReferenceResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The metadata of the saved file or folder in the user's Dropbox.
@property (nonatomic, readonly) DBFILESMetadata *metadata;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param metadata The metadata of the saved file or folder in the user's
/// Dropbox.
///
/// @return An initialized instance.
///
- (instancetype)initWithMetadata:(DBFILESMetadata *)metadata;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `SaveCopyReferenceResult` struct.
///
@interface DBFILESSaveCopyReferenceResultSerializer : NSObject

///
/// Serializes `DBFILESSaveCopyReferenceResult` instances.
///
/// @param instance An instance of the `DBFILESSaveCopyReferenceResult` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESSaveCopyReferenceResult` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILESSaveCopyReferenceResult *)instance;

///
/// Deserializes `DBFILESSaveCopyReferenceResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESSaveCopyReferenceResult` API object.
///
/// @return An instantiation of the `DBFILESSaveCopyReferenceResult` object.
///
+ (DBFILESSaveCopyReferenceResult *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
