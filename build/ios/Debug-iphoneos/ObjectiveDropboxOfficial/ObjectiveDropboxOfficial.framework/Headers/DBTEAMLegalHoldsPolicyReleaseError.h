///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLegalHoldsPolicyReleaseError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `LegalHoldsPolicyReleaseError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLegalHoldsPolicyReleaseError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMLegalHoldsPolicyReleaseErrorTag` enum type represents the
/// possible tag states with which the `DBTEAMLegalHoldsPolicyReleaseError`
/// union can exist.
typedef NS_CLOSED_ENUM(NSInteger, DBTEAMLegalHoldsPolicyReleaseErrorTag){
    /// There has been an unknown legal hold error.
    DBTEAMLegalHoldsPolicyReleaseErrorUnknownLegalHoldError,

    /// You don't have permissions to perform this action.
    DBTEAMLegalHoldsPolicyReleaseErrorInsufficientPermissions,

    /// (no description).
    DBTEAMLegalHoldsPolicyReleaseErrorOther,

    /// Legal hold is currently performing another operation.
    DBTEAMLegalHoldsPolicyReleaseErrorLegalHoldPerformingAnotherOperation,

    /// Legal hold is currently performing a release or is already released.
    DBTEAMLegalHoldsPolicyReleaseErrorLegalHoldAlreadyReleasing,

    /// Legal hold policy does not exist for `id_` in
    /// `DBTEAMLegalHoldsPolicyReleaseArg`.
    DBTEAMLegalHoldsPolicyReleaseErrorLegalHoldPolicyNotFound,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMLegalHoldsPolicyReleaseErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "unknown_legal_hold_error".
///
/// Description of the "unknown_legal_hold_error" tag state: There has been an
/// unknown legal hold error.
///
/// @return An initialized instance.
///
- (instancetype)initWithUnknownLegalHoldError;

///
/// Initializes union class with tag state of "insufficient_permissions".
///
/// Description of the "insufficient_permissions" tag state: You don't have
/// permissions to perform this action.
///
/// @return An initialized instance.
///
- (instancetype)initWithInsufficientPermissions;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

///
/// Initializes union class with tag state of
/// "legal_hold_performing_another_operation".
///
/// Description of the "legal_hold_performing_another_operation" tag state:
/// Legal hold is currently performing another operation.
///
/// @return An initialized instance.
///
- (instancetype)initWithLegalHoldPerformingAnotherOperation;

///
/// Initializes union class with tag state of "legal_hold_already_releasing".
///
/// Description of the "legal_hold_already_releasing" tag state: Legal hold is
/// currently performing a release or is already released.
///
/// @return An initialized instance.
///
- (instancetype)initWithLegalHoldAlreadyReleasing;

///
/// Initializes union class with tag state of "legal_hold_policy_not_found".
///
/// Description of the "legal_hold_policy_not_found" tag state: Legal hold
/// policy does not exist for `id_` in `DBTEAMLegalHoldsPolicyReleaseArg`.
///
/// @return An initialized instance.
///
- (instancetype)initWithLegalHoldPolicyNotFound;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value
/// "unknown_legal_hold_error".
///
/// @return Whether the union's current tag state has value
/// "unknown_legal_hold_error".
///
- (BOOL)isUnknownLegalHoldError;

///
/// Retrieves whether the union's current tag state has value
/// "insufficient_permissions".
///
/// @return Whether the union's current tag state has value
/// "insufficient_permissions".
///
- (BOOL)isInsufficientPermissions;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves whether the union's current tag state has value
/// "legal_hold_performing_another_operation".
///
/// @return Whether the union's current tag state has value
/// "legal_hold_performing_another_operation".
///
- (BOOL)isLegalHoldPerformingAnotherOperation;

///
/// Retrieves whether the union's current tag state has value
/// "legal_hold_already_releasing".
///
/// @return Whether the union's current tag state has value
/// "legal_hold_already_releasing".
///
- (BOOL)isLegalHoldAlreadyReleasing;

///
/// Retrieves whether the union's current tag state has value
/// "legal_hold_policy_not_found".
///
/// @return Whether the union's current tag state has value
/// "legal_hold_policy_not_found".
///
- (BOOL)isLegalHoldPolicyNotFound;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBTEAMLegalHoldsPolicyReleaseError` union.
///
@interface DBTEAMLegalHoldsPolicyReleaseErrorSerializer : NSObject

///
/// Serializes `DBTEAMLegalHoldsPolicyReleaseError` instances.
///
/// @param instance An instance of the `DBTEAMLegalHoldsPolicyReleaseError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLegalHoldsPolicyReleaseError` API object.
///
+ (nullable NSDictionary<NSString *, id> *)serialize:(DBTEAMLegalHoldsPolicyReleaseError *)instance;

///
/// Deserializes `DBTEAMLegalHoldsPolicyReleaseError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLegalHoldsPolicyReleaseError` API object.
///
/// @return An instantiation of the `DBTEAMLegalHoldsPolicyReleaseError` object.
///
+ (DBTEAMLegalHoldsPolicyReleaseError *)deserialize:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
