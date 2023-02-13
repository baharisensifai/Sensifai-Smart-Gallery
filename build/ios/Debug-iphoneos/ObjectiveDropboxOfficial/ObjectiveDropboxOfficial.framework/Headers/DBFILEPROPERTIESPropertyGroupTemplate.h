///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILEPROPERTIESPropertyFieldTemplate;
@class DBFILEPROPERTIESPropertyGroupTemplate;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `PropertyGroupTemplate` struct.
///
/// Defines how a property group may be structured.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILEPROPERTIESPropertyGroupTemplate : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Display name for the template. Template names can be up to 256 bytes.
@property (nonatomic, readonly, copy) NSString *name;

/// Description for the template. Template descriptions can be up to 1024 bytes.
@property (nonatomic, readonly, copy) NSString *description_;

/// Definitions of the property fields associated with this template. There can
/// be up to 32 properties in a single template.
@property (nonatomic, readonly) NSArray<DBFILEPROPERTIESPropertyFieldTemplate *> *fields;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param name Display name for the template. Template names can be up to 256
/// bytes.
/// @param description_ Description for the template. Template descriptions can
/// be up to 1024 bytes.
/// @param fields Definitions of the property fields associated with this
/// template. There can be up to 32 properties in a single template.
///
/// @return An initialized instance.
///
- (instancetype)initWithName:(NSString *)name
                description_:(NSString *)description_
                      fields:(NSArray<DBFILEPROPERTIESPropertyFieldTemplate *> *)fields;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `PropertyGroupTemplate` struct.
///
@interface DBFILEPROPERTIESPropertyGroupTemplateSerializer : NSObject

///
/// Serializes `DBFILEPROPERTIESPropertyGroupTemplate` instances.
///
/// @param instance An instance of the `DBFILEPROPERTIESPropertyGroupTemplate`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILEPROPERTIESPropertyGroupTemplate` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILEPROPERTIESPropertyGroupTemplate *)instance;

///
/// Deserializes `DBFILEPROPERTIESPropertyGroupTemplate` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILEPROPERTIESPropertyGroupTemplate` API object.
///
/// @return An instantiation of the `DBFILEPROPERTIESPropertyGroupTemplate`
/// object.
///
+ (DBFILEPROPERTIESPropertyGroupTemplate *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
