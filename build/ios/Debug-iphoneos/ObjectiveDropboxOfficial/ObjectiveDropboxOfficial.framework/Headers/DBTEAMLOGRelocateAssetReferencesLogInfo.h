///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGRelocateAssetReferencesLogInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `RelocateAssetReferencesLogInfo` struct.
///
/// Provides the indices of the source asset and the destination asset for a
/// relocate action.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGRelocateAssetReferencesLogInfo : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Source asset position in the Assets list.
@property (nonatomic, readonly) NSNumber *srcAssetIndex;

/// Destination asset position in the Assets list.
@property (nonatomic, readonly) NSNumber *destAssetIndex;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param srcAssetIndex Source asset position in the Assets list.
/// @param destAssetIndex Destination asset position in the Assets list.
///
/// @return An initialized instance.
///
- (instancetype)initWithSrcAssetIndex:(NSNumber *)srcAssetIndex destAssetIndex:(NSNumber *)destAssetIndex;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `RelocateAssetReferencesLogInfo` struct.
///
@interface DBTEAMLOGRelocateAssetReferencesLogInfoSerializer : NSObject

///
/// Serializes `DBTEAMLOGRelocateAssetReferencesLogInfo` instances.
///
/// @param instance An instance of the `DBTEAMLOGRelocateAssetReferencesLogInfo`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGRelocateAssetReferencesLogInfo` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGRelocateAssetReferencesLogInfo *)instance;

///
/// Deserializes `DBTEAMLOGRelocateAssetReferencesLogInfo` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGRelocateAssetReferencesLogInfo` API object.
///
/// @return An instantiation of the `DBTEAMLOGRelocateAssetReferencesLogInfo`
/// object.
///
+ (DBTEAMLOGRelocateAssetReferencesLogInfo *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
