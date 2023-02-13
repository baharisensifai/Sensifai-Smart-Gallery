///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGPaperDocTeamInviteDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `PaperDocTeamInviteDetails` struct.
///
/// Shared Paper doc with users and/or groups.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGPaperDocTeamInviteDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Event unique identifier.
@property (nonatomic, readonly, copy) NSString *eventUuid;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param eventUuid Event unique identifier.
///
/// @return An initialized instance.
///
- (instancetype)initWithEventUuid:(NSString *)eventUuid;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `PaperDocTeamInviteDetails` struct.
///
@interface DBTEAMLOGPaperDocTeamInviteDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGPaperDocTeamInviteDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGPaperDocTeamInviteDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGPaperDocTeamInviteDetails` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLOGPaperDocTeamInviteDetails *)instance;

///
/// Deserializes `DBTEAMLOGPaperDocTeamInviteDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGPaperDocTeamInviteDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGPaperDocTeamInviteDetails` object.
///
+ (DBTEAMLOGPaperDocTeamInviteDetails *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
