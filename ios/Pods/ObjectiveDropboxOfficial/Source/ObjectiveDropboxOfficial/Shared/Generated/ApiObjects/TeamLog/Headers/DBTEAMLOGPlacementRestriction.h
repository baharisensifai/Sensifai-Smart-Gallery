///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGPlacementRestriction;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `PlacementRestriction` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGPlacementRestriction : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMLOGPlacementRestrictionTag` enum type represents the possible tag
/// states with which the `DBTEAMLOGPlacementRestriction` union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMLOGPlacementRestrictionTag){
    /// (no description).
    DBTEAMLOGPlacementRestrictionAustraliaOnly,

    /// (no description).
    DBTEAMLOGPlacementRestrictionEuropeOnly,

    /// (no description).
    DBTEAMLOGPlacementRestrictionJapanOnly,

    /// (no description).
    DBTEAMLOGPlacementRestrictionNone,

    /// (no description).
    DBTEAMLOGPlacementRestrictionUkOnly,

    /// (no description).
    DBTEAMLOGPlacementRestrictionUsS3Only,

    /// (no description).
    DBTEAMLOGPlacementRestrictionOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMLOGPlacementRestrictionTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "australia_only".
///
/// @return An initialized instance.
///
- (instancetype)initWithAustraliaOnly;

///
/// Initializes union class with tag state of "europe_only".
///
/// @return An initialized instance.
///
- (instancetype)initWithEuropeOnly;

///
/// Initializes union class with tag state of "japan_only".
///
/// @return An initialized instance.
///
- (instancetype)initWithJapanOnly;

///
/// Initializes union class with tag state of "none".
///
/// @return An initialized instance.
///
- (instancetype)initWithNone;

///
/// Initializes union class with tag state of "uk_only".
///
/// @return An initialized instance.
///
- (instancetype)initWithUkOnly;

///
/// Initializes union class with tag state of "us_s3_only".
///
/// @return An initialized instance.
///
- (instancetype)initWithUsS3Only;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "australia_only".
///
/// @return Whether the union's current tag state has value "australia_only".
///
- (BOOL)isAustraliaOnly;

///
/// Retrieves whether the union's current tag state has value "europe_only".
///
/// @return Whether the union's current tag state has value "europe_only".
///
- (BOOL)isEuropeOnly;

///
/// Retrieves whether the union's current tag state has value "japan_only".
///
/// @return Whether the union's current tag state has value "japan_only".
///
- (BOOL)isJapanOnly;

///
/// Retrieves whether the union's current tag state has value "none".
///
/// @return Whether the union's current tag state has value "none".
///
- (BOOL)isNone;

///
/// Retrieves whether the union's current tag state has value "uk_only".
///
/// @return Whether the union's current tag state has value "uk_only".
///
- (BOOL)isUkOnly;

///
/// Retrieves whether the union's current tag state has value "us_s3_only".
///
/// @return Whether the union's current tag state has value "us_s3_only".
///
- (BOOL)isUsS3Only;

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
/// The serialization class for the `DBTEAMLOGPlacementRestriction` union.
///
@interface DBTEAMLOGPlacementRestrictionSerializer : NSObject

///
/// Serializes `DBTEAMLOGPlacementRestriction` instances.
///
/// @param instance An instance of the `DBTEAMLOGPlacementRestriction` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGPlacementRestriction` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGPlacementRestriction *)instance;

///
/// Deserializes `DBTEAMLOGPlacementRestriction` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGPlacementRestriction` API object.
///
/// @return An instantiation of the `DBTEAMLOGPlacementRestriction` object.
///
+ (DBTEAMLOGPlacementRestriction *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
