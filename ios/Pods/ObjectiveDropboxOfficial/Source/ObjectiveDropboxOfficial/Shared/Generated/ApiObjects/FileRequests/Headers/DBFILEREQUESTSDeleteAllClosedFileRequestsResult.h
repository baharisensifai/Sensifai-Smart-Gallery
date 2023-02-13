///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILEREQUESTSDeleteAllClosedFileRequestsResult;
@class DBFILEREQUESTSFileRequest;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `DeleteAllClosedFileRequestsResult` struct.
///
/// Result for `deleteAllClosed`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILEREQUESTSDeleteAllClosedFileRequestsResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The file requests deleted for this user.
@property (nonatomic, readonly) NSArray<DBFILEREQUESTSFileRequest *> *fileRequests;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param fileRequests The file requests deleted for this user.
///
/// @return An initialized instance.
///
- (instancetype)initWithFileRequests:(NSArray<DBFILEREQUESTSFileRequest *> *)fileRequests;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DeleteAllClosedFileRequestsResult` struct.
///
@interface DBFILEREQUESTSDeleteAllClosedFileRequestsResultSerializer : NSObject

///
/// Serializes `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` instances.
///
/// @param instance An instance of the
/// `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILEREQUESTSDeleteAllClosedFileRequestsResult *)instance;

///
/// Deserializes `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` API object.
///
/// @return An instantiation of the
/// `DBFILEREQUESTSDeleteAllClosedFileRequestsResult` object.
///
+ (DBFILEREQUESTSDeleteAllClosedFileRequestsResult *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
