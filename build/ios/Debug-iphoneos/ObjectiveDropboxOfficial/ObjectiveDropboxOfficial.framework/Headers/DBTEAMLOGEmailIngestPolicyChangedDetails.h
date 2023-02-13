///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGEmailIngestPolicy;
@class DBTEAMLOGEmailIngestPolicyChangedDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `EmailIngestPolicyChangedDetails` struct.
///
/// Changed email to Dropbox policy for team.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGEmailIngestPolicyChangedDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// To.
@property (nonatomic, readonly) DBTEAMLOGEmailIngestPolicy *dNewValue;

/// From.
@property (nonatomic, readonly) DBTEAMLOGEmailIngestPolicy *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewValue To.
/// @param previousValue From.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(DBTEAMLOGEmailIngestPolicy *)dNewValue
                    previousValue:(DBTEAMLOGEmailIngestPolicy *)previousValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `EmailIngestPolicyChangedDetails` struct.
///
@interface DBTEAMLOGEmailIngestPolicyChangedDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGEmailIngestPolicyChangedDetails` instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGEmailIngestPolicyChangedDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGEmailIngestPolicyChangedDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGEmailIngestPolicyChangedDetails *)instance;

///
/// Deserializes `DBTEAMLOGEmailIngestPolicyChangedDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGEmailIngestPolicyChangedDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGEmailIngestPolicyChangedDetails`
/// object.
///
+ (DBTEAMLOGEmailIngestPolicyChangedDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END