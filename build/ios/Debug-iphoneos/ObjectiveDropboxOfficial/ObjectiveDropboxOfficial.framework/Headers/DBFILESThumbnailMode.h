///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESThumbnailMode;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ThumbnailMode` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESThumbnailMode : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBFILESThumbnailModeTag` enum type represents the possible tag states
/// with which the `DBFILESThumbnailMode` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBFILESThumbnailModeTag){
    /// Scale down the image to fit within the given size.
    DBFILESThumbnailModeStrict,

    /// Scale down the image to fit within the given size or its transpose.
    DBFILESThumbnailModeBestfit,

    /// Scale down the image to completely cover the given size or its
    /// transpose.
    DBFILESThumbnailModeFitoneBestfit,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBFILESThumbnailModeTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "strict".
///
/// Description of the "strict" tag state: Scale down the image to fit within
/// the given size.
///
/// @return An initialized instance.
///
- (instancetype)initWithStrict;

///
/// Initializes union class with tag state of "bestfit".
///
/// Description of the "bestfit" tag state: Scale down the image to fit within
/// the given size or its transpose.
///
/// @return An initialized instance.
///
- (instancetype)initWithBestfit;

///
/// Initializes union class with tag state of "fitone_bestfit".
///
/// Description of the "fitone_bestfit" tag state: Scale down the image to
/// completely cover the given size or its transpose.
///
/// @return An initialized instance.
///
- (instancetype)initWithFitoneBestfit;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "strict".
///
/// @return Whether the union's current tag state has value "strict".
///
- (BOOL)isStrict;

///
/// Retrieves whether the union's current tag state has value "bestfit".
///
/// @return Whether the union's current tag state has value "bestfit".
///
- (BOOL)isBestfit;

///
/// Retrieves whether the union's current tag state has value "fitone_bestfit".
///
/// @return Whether the union's current tag state has value "fitone_bestfit".
///
- (BOOL)isFitoneBestfit;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBFILESThumbnailMode` union.
///
@interface DBFILESThumbnailModeSerializer : NSObject

///
/// Serializes `DBFILESThumbnailMode` instances.
///
/// @param instance An instance of the `DBFILESThumbnailMode` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESThumbnailMode` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILESThumbnailMode *)instance;

///
/// Deserializes `DBFILESThumbnailMode` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESThumbnailMode` API object.
///
/// @return An instantiation of the `DBFILESThumbnailMode` object.
///
+ (DBFILESThumbnailMode *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
