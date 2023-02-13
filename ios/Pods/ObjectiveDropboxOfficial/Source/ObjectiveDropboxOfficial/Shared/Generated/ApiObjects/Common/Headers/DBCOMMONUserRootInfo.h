///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBCOMMONRootInfo.h"
#import "DBSerializableProtocol.h"

@class DBCOMMONUserRootInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `UserRootInfo` struct.
///
/// Root info when user is not member of a team or the user is a member of a
/// team and the team does not have a separate root namespace.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBCOMMONUserRootInfo : DBCOMMONRootInfo <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param rootNamespaceId The namespace ID for user's root namespace. It will
/// be the namespace ID of the shared team root if the user is member of a team
/// with a separate team root. Otherwise it will be same as `homeNamespaceId` in
/// `DBCOMMONRootInfo`.
/// @param homeNamespaceId The namespace ID for user's home namespace.
///
/// @return An initialized instance.
///
- (instancetype)initWithRootNamespaceId:(NSString *)rootNamespaceId homeNamespaceId:(NSString *)homeNamespaceId;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `UserRootInfo` struct.
///
@interface DBCOMMONUserRootInfoSerializer : NSObject

///
/// Serializes `DBCOMMONUserRootInfo` instances.
///
/// @param instance An instance of the `DBCOMMONUserRootInfo` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBCOMMONUserRootInfo` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBCOMMONUserRootInfo *)instance;

///
/// Deserializes `DBCOMMONUserRootInfo` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBCOMMONUserRootInfo` API object.
///
/// @return An instantiation of the `DBCOMMONUserRootInfo` object.
///
+ (DBCOMMONUserRootInfo *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
