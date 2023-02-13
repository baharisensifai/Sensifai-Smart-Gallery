#import <Foundation/Foundation.h>


#import <MLKitImageLabelingCommon/MLKCommonImageLabelerOptions.h>

@class MLKCustomRemoteModel;
@class MLKLocalModel;

NS_ASSUME_NONNULL_BEGIN

/** Configurations for a custom-model image labeler. */
NS_SWIFT_NAME(CustomImageLabelerOptions)
@interface MLKCustomImageLabelerOptions : MLKCommonImageLabelerOptions

/**
 * The maximum number of labels to return for an image. Must be positive. If unset or an invalid
 * value is set, the default value of `10` is used.
 */
@property(nonatomic) NSInteger maxResultCount;

/**
 * Initializes a `CustomImageLabelerOptions` instance using the given `LocalModel` with the
 * `confidenceThreshold` property set to `nil`. If that remains unset, it will use the
 * confidence threshold value included in the model metadata, if available. If that does not exist,
 * a value of `0.0` will be used instead.
 *
 * @param localModel A custom image labeling model stored locally on the device.
 * @return A new instance of `CustomImageLabelerOptions` with the given `LocalModel`.
 */
- (instancetype)initWithLocalModel:(MLKLocalModel *)localModel;

/**
 * Initializes a `CustomImageLabelerOptions` instance using the given `CustomRemoteModel` with the
 * `confidenceThreshold` property set to `nil`. If that remains unset, it will use the confidence
 * threshold value included in the model metadata, if available. If that does not exist, a value of
 * `0.0` will be used instead.
 *
 * @param remoteModel A custom image labeling model stored remotely on the server and downloaded to
 *     the device.
 * @return A new instance of `CustomImageLabelerOptions` with the given `CustomRemoteModel`.
 */
- (instancetype)initWithRemoteModel:(MLKCustomRemoteModel *)remoteModel;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
