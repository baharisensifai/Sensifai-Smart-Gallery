///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGFileAddCommentDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `FileAddCommentDetails` struct.
///
/// Added file comment.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGFileAddCommentDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Comment text.
@property (nonatomic, readonly, copy, nullable) NSString *commentText;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param commentText Comment text.
///
/// @return An initialized instance.
///
- (instancetype)initWithCommentText:(nullable NSString *)commentText;

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
/// The serialization class for the `FileAddCommentDetails` struct.
///
@interface DBTEAMLOGFileAddCommentDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGFileAddCommentDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGFileAddCommentDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGFileAddCommentDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGFileAddCommentDetails *)instance;

///
/// Deserializes `DBTEAMLOGFileAddCommentDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGFileAddCommentDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGFileAddCommentDetails` object.
///
+ (DBTEAMLOGFileAddCommentDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
