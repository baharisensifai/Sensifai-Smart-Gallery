///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESUploadSessionStartBatchResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `UploadSessionStartBatchResult` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESUploadSessionStartBatchResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// A List of unique identifiers for the upload session. Pass each session_id to
/// `uploadSessionAppend` and `uploadSessionFinish`.
@property (nonatomic, readonly) NSArray<NSString *> *sessionIds;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param sessionIds A List of unique identifiers for the upload session. Pass
/// each session_id to `uploadSessionAppend` and `uploadSessionFinish`.
///
/// @return An initialized instance.
///
- (instancetype)initWithSessionIds:(NSArray<NSString *> *)sessionIds;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `UploadSessionStartBatchResult` struct.
///
@interface DBFILESUploadSessionStartBatchResultSerializer : NSObject

///
/// Serializes `DBFILESUploadSessionStartBatchResult` instances.
///
/// @param instance An instance of the `DBFILESUploadSessionStartBatchResult`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESUploadSessionStartBatchResult` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILESUploadSessionStartBatchResult *)instance;

///
/// Deserializes `DBFILESUploadSessionStartBatchResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESUploadSessionStartBatchResult` API object.
///
/// @return An instantiation of the `DBFILESUploadSessionStartBatchResult`
/// object.
///
+ (DBFILESUploadSessionStartBatchResult *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
