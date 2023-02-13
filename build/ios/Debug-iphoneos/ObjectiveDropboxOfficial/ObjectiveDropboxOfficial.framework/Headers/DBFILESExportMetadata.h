///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESExportMetadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ExportMetadata` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESExportMetadata : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The last component of the path (including extension). This never contains a
/// slash.
@property (nonatomic, readonly, copy) NSString *name;

/// The file size in bytes.
@property (nonatomic, readonly) NSNumber *size;

/// A hash based on the exported file content. This field can be used to verify
/// data integrity. Similar to content hash. For more information see our
/// Content hash https://www.dropbox.com/developers/reference/content-hash page.
@property (nonatomic, readonly, copy, nullable) NSString *exportHash;

/// If the file is a Paper doc, this gives the latest doc revision which can be
/// used in `paperUpdate`.
@property (nonatomic, readonly, nullable) NSNumber *paperRevision;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param name The last component of the path (including extension). This never
/// contains a slash.
/// @param size The file size in bytes.
/// @param exportHash A hash based on the exported file content. This field can
/// be used to verify data integrity. Similar to content hash. For more
/// information see our Content hash
/// https://www.dropbox.com/developers/reference/content-hash page.
/// @param paperRevision If the file is a Paper doc, this gives the latest doc
/// revision which can be used in `paperUpdate`.
///
/// @return An initialized instance.
///
- (instancetype)initWithName:(NSString *)name
                        size:(NSNumber *)size
                  exportHash:(nullable NSString *)exportHash
               paperRevision:(nullable NSNumber *)paperRevision;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param name The last component of the path (including extension). This never
/// contains a slash.
/// @param size The file size in bytes.
///
/// @return An initialized instance.
///
- (instancetype)initWithName:(NSString *)name size:(NSNumber *)size;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ExportMetadata` struct.
///
@interface DBFILESExportMetadataSerializer : NSObject

///
/// Serializes `DBFILESExportMetadata` instances.
///
/// @param instance An instance of the `DBFILESExportMetadata` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESExportMetadata` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBFILESExportMetadata *)instance;

///
/// Deserializes `DBFILESExportMetadata` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESExportMetadata` API object.
///
/// @return An instantiation of the `DBFILESExportMetadata` object.
///
+ (DBFILESExportMetadata *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
