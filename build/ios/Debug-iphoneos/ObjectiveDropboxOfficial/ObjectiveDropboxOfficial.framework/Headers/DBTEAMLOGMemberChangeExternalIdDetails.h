///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGMemberChangeExternalIdDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MemberChangeExternalIdDetails` struct.
///
/// Changed the external ID for team member.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGMemberChangeExternalIdDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Current external id.
@property (nonatomic, readonly, copy) NSString *dNewValue;

/// Old external id.
@property (nonatomic, readonly, copy) NSString *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewValue Current external id.
/// @param previousValue Old external id.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(NSString *)dNewValue previousValue:(NSString *)previousValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `MemberChangeExternalIdDetails` struct.
///
@interface DBTEAMLOGMemberChangeExternalIdDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGMemberChangeExternalIdDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGMemberChangeExternalIdDetails`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberChangeExternalIdDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGMemberChangeExternalIdDetails *)instance;

///
/// Deserializes `DBTEAMLOGMemberChangeExternalIdDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberChangeExternalIdDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGMemberChangeExternalIdDetails`
/// object.
///
+ (DBTEAMLOGMemberChangeExternalIdDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END