///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

/// Arguments, results, and errors for the `Openid` namespace.

#import "DBOPENIDAuthError.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBOPENIDAuthError

#pragma mark - Constructors

- (instancetype)initWithInvalidToken {
  self = [super init];
  if (self) {
    _tag = DBOPENIDAuthErrorInvalidToken;
  }
  return self;
}

- (instancetype)initWithNoOpenidAuth {
  self = [super init];
  if (self) {
    _tag = DBOPENIDAuthErrorNoOpenidAuth;
  }
  return self;
}

- (instancetype)initWithOther {
  self = [super init];
  if (self) {
    _tag = DBOPENIDAuthErrorOther;
  }
  return self;
}

#pragma mark - Instance field accessors

#pragma mark - Tag state methods

- (BOOL)isInvalidToken {
  return _tag == DBOPENIDAuthErrorInvalidToken;
}

- (BOOL)isNoOpenidAuth {
  return _tag == DBOPENIDAuthErrorNoOpenidAuth;
}

- (BOOL)isOther {
  return _tag == DBOPENIDAuthErrorOther;
}

- (NSString *)tagName {
  switch (_tag) {
  case DBOPENIDAuthErrorInvalidToken:
    return @"DBOPENIDAuthErrorInvalidToken";
  case DBOPENIDAuthErrorNoOpenidAuth:
    return @"DBOPENIDAuthErrorNoOpenidAuth";
  case DBOPENIDAuthErrorOther:
    return @"DBOPENIDAuthErrorOther";
  }

  @throw([NSException exceptionWithName:@"InvalidTag" reason:@"Tag has an unknown value." userInfo:nil]);
}

#pragma mark - Serialization methods

+ (nullable NSDictionary<NSString *, id> *)serialize:(id)instance {
  return [DBOPENIDAuthErrorSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary<NSString *, id> *)dict {
  return [DBOPENIDAuthErrorSerializer deserialize:dict];
}

#pragma mark - Debug Description method

- (NSString *)debugDescription {
  return [[DBOPENIDAuthErrorSerializer serialize:self] description];
}

#pragma mark - Copyable method

- (instancetype)copyWithZone:(NSZone *)zone {
#pragma unused(zone)
  /// object is immutable
  return self;
}

#pragma mark - Hash method

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;

  switch (_tag) {
  case DBOPENIDAuthErrorInvalidToken:
    result = prime * result + [[self tagName] hash];
    break;
  case DBOPENIDAuthErrorNoOpenidAuth:
    result = prime * result + [[self tagName] hash];
    break;
  case DBOPENIDAuthErrorOther:
    result = prime * result + [[self tagName] hash];
    break;
  }

  return prime * result;
}

#pragma mark - Equality method

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![other isKindOfClass:[self class]]) {
    return NO;
  }
  return [self isEqualToAuthError:other];
}

- (BOOL)isEqualToAuthError:(DBOPENIDAuthError *)anAuthError {
  if (self == anAuthError) {
    return YES;
  }
  if (self.tag != anAuthError.tag) {
    return NO;
  }
  switch (_tag) {
  case DBOPENIDAuthErrorInvalidToken:
    return [[self tagName] isEqual:[anAuthError tagName]];
  case DBOPENIDAuthErrorNoOpenidAuth:
    return [[self tagName] isEqual:[anAuthError tagName]];
  case DBOPENIDAuthErrorOther:
    return [[self tagName] isEqual:[anAuthError tagName]];
  }
  return YES;
}

@end

#pragma mark - Serializer Object

@implementation DBOPENIDAuthErrorSerializer

+ (NSDictionary<NSString *, id> *)serialize:(DBOPENIDAuthError *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if ([valueObj isInvalidToken]) {
    jsonDict[@".tag"] = @"invalid_token";
  } else if ([valueObj isNoOpenidAuth]) {
    jsonDict[@".tag"] = @"no_openid_auth";
  } else if ([valueObj isOther]) {
    jsonDict[@".tag"] = @"other";
  } else {
    jsonDict[@".tag"] = @"other";
  }

  return [jsonDict count] > 0 ? jsonDict : nil;
}

+ (DBOPENIDAuthError *)deserialize:(NSDictionary<NSString *, id> *)valueDict {
  NSString *tag = valueDict[@".tag"];

  if ([tag isEqualToString:@"invalid_token"]) {
    return [[DBOPENIDAuthError alloc] initWithInvalidToken];
  } else if ([tag isEqualToString:@"no_openid_auth"]) {
    return [[DBOPENIDAuthError alloc] initWithNoOpenidAuth];
  } else if ([tag isEqualToString:@"other"]) {
    return [[DBOPENIDAuthError alloc] initWithOther];
  } else {
    return [[DBOPENIDAuthError alloc] initWithOther];
  }
}

@end

#import "DBOPENIDUserInfoArgs.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBOPENIDUserInfoArgs

#pragma mark - Constructors

- (instancetype)initDefault {

  self = [super init];
  if (self) {
  }
  return self;
}

#pragma mark - Serialization methods

+ (nullable NSDictionary<NSString *, id> *)serialize:(id)instance {
  return [DBOPENIDUserInfoArgsSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary<NSString *, id> *)dict {
  return [DBOPENIDUserInfoArgsSerializer deserialize:dict];
}

#pragma mark - Debug Description method

- (NSString *)debugDescription {
  return [[DBOPENIDUserInfoArgsSerializer serialize:self] description];
}

#pragma mark - Copyable method

- (instancetype)copyWithZone:(NSZone *)zone {
#pragma unused(zone)
  /// object is immutable
  return self;
}

#pragma mark - Hash method

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;

  return prime * result;
}

#pragma mark - Equality method

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![other isKindOfClass:[self class]]) {
    return NO;
  }
  return [self isEqualToUserInfoArgs:other];
}

- (BOOL)isEqualToUserInfoArgs:(DBOPENIDUserInfoArgs *)anUserInfoArgs {
  if (self == anUserInfoArgs) {
    return YES;
  }
  return YES;
}

@end

#pragma mark - Serializer Object

@implementation DBOPENIDUserInfoArgsSerializer

+ (NSDictionary<NSString *, id> *)serialize:(DBOPENIDUserInfoArgs *)valueObj {
#pragma unused(valueObj)
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  return [jsonDict count] > 0 ? jsonDict : nil;
}

+ (DBOPENIDUserInfoArgs *)deserialize:(NSDictionary<NSString *, id> *)valueDict {
#pragma unused(valueDict)

  return [[DBOPENIDUserInfoArgs alloc] initDefault];
}

@end

#import "DBOPENIDErrUnion.h"
#import "DBOPENIDUserInfoError.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBOPENIDUserInfoError

#pragma mark - Constructors

- (instancetype)initWithErr:(DBOPENIDErrUnion *)err errorMessage:(NSString *)errorMessage {

  self = [super init];
  if (self) {
    _err = err;
    _errorMessage = errorMessage ?: @"";
  }
  return self;
}

- (instancetype)initDefault {
  return [self initWithErr:nil errorMessage:nil];
}

#pragma mark - Serialization methods

+ (nullable NSDictionary<NSString *, id> *)serialize:(id)instance {
  return [DBOPENIDUserInfoErrorSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary<NSString *, id> *)dict {
  return [DBOPENIDUserInfoErrorSerializer deserialize:dict];
}

#pragma mark - Debug Description method

- (NSString *)debugDescription {
  return [[DBOPENIDUserInfoErrorSerializer serialize:self] description];
}

#pragma mark - Copyable method

- (instancetype)copyWithZone:(NSZone *)zone {
#pragma unused(zone)
  /// object is immutable
  return self;
}

#pragma mark - Hash method

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;

  if (self.err != nil) {
    result = prime * result + [self.err hash];
  }
  result = prime * result + [self.errorMessage hash];

  return prime * result;
}

#pragma mark - Equality method

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![other isKindOfClass:[self class]]) {
    return NO;
  }
  return [self isEqualToUserInfoError:other];
}

- (BOOL)isEqualToUserInfoError:(DBOPENIDUserInfoError *)anUserInfoError {
  if (self == anUserInfoError) {
    return YES;
  }
  if (self.err) {
    if (![self.err isEqual:anUserInfoError.err]) {
      return NO;
    }
  }
  if (![self.errorMessage isEqual:anUserInfoError.errorMessage]) {
    return NO;
  }
  return YES;
}

@end

#pragma mark - Serializer Object

@implementation DBOPENIDUserInfoErrorSerializer

+ (NSDictionary<NSString *, id> *)serialize:(DBOPENIDUserInfoError *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if (valueObj.err) {
    jsonDict[@"err"] = [DBOPENIDErrUnionSerializer serialize:valueObj.err];
  }
  jsonDict[@"error_message"] = valueObj.errorMessage;

  return [jsonDict count] > 0 ? jsonDict : nil;
}

+ (DBOPENIDUserInfoError *)deserialize:(NSDictionary<NSString *, id> *)valueDict {
  DBOPENIDErrUnion *err = valueDict[@"err"] ? [DBOPENIDErrUnionSerializer deserialize:valueDict[@"err"]] : nil;
  NSString *errorMessage = valueDict[@"error_message"] ?: @"";

  return [[DBOPENIDUserInfoError alloc] initWithErr:err errorMessage:errorMessage];
}

@end

#import "DBOPENIDUserInfoResult.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBOPENIDUserInfoResult

#pragma mark - Constructors

- (instancetype)initWithFamilyName:(NSString *)familyName
                         givenName:(NSString *)givenName
                             email:(NSString *)email
                     emailVerified:(NSNumber *)emailVerified
                               iss:(NSString *)iss
                               sub:(NSString *)sub {

  self = [super init];
  if (self) {
    _familyName = familyName;
    _givenName = givenName;
    _email = email;
    _emailVerified = emailVerified;
    _iss = iss ?: @"";
    _sub = sub ?: @"";
  }
  return self;
}

- (instancetype)initDefault {
  return [self initWithFamilyName:nil givenName:nil email:nil emailVerified:nil iss:nil sub:nil];
}

#pragma mark - Serialization methods

+ (nullable NSDictionary<NSString *, id> *)serialize:(id)instance {
  return [DBOPENIDUserInfoResultSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary<NSString *, id> *)dict {
  return [DBOPENIDUserInfoResultSerializer deserialize:dict];
}

#pragma mark - Debug Description method

- (NSString *)debugDescription {
  return [[DBOPENIDUserInfoResultSerializer serialize:self] description];
}

#pragma mark - Copyable method

- (instancetype)copyWithZone:(NSZone *)zone {
#pragma unused(zone)
  /// object is immutable
  return self;
}

#pragma mark - Hash method

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;

  if (self.familyName != nil) {
    result = prime * result + [self.familyName hash];
  }
  if (self.givenName != nil) {
    result = prime * result + [self.givenName hash];
  }
  if (self.email != nil) {
    result = prime * result + [self.email hash];
  }
  if (self.emailVerified != nil) {
    result = prime * result + [self.emailVerified hash];
  }
  result = prime * result + [self.iss hash];
  result = prime * result + [self.sub hash];

  return prime * result;
}

#pragma mark - Equality method

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![other isKindOfClass:[self class]]) {
    return NO;
  }
  return [self isEqualToUserInfoResult:other];
}

- (BOOL)isEqualToUserInfoResult:(DBOPENIDUserInfoResult *)anUserInfoResult {
  if (self == anUserInfoResult) {
    return YES;
  }
  if (self.familyName) {
    if (![self.familyName isEqual:anUserInfoResult.familyName]) {
      return NO;
    }
  }
  if (self.givenName) {
    if (![self.givenName isEqual:anUserInfoResult.givenName]) {
      return NO;
    }
  }
  if (self.email) {
    if (![self.email isEqual:anUserInfoResult.email]) {
      return NO;
    }
  }
  if (self.emailVerified) {
    if (![self.emailVerified isEqual:anUserInfoResult.emailVerified]) {
      return NO;
    }
  }
  if (![self.iss isEqual:anUserInfoResult.iss]) {
    return NO;
  }
  if (![self.sub isEqual:anUserInfoResult.sub]) {
    return NO;
  }
  return YES;
}

@end

#pragma mark - Serializer Object

@implementation DBOPENIDUserInfoResultSerializer

+ (NSDictionary<NSString *, id> *)serialize:(DBOPENIDUserInfoResult *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if (valueObj.familyName) {
    jsonDict[@"family_name"] = valueObj.familyName;
  }
  if (valueObj.givenName) {
    jsonDict[@"given_name"] = valueObj.givenName;
  }
  if (valueObj.email) {
    jsonDict[@"email"] = valueObj.email;
  }
  if (valueObj.emailVerified) {
    jsonDict[@"email_verified"] = valueObj.emailVerified;
  }
  jsonDict[@"iss"] = valueObj.iss;
  jsonDict[@"sub"] = valueObj.sub;

  return [jsonDict count] > 0 ? jsonDict : nil;
}

+ (DBOPENIDUserInfoResult *)deserialize:(NSDictionary<NSString *, id> *)valueDict {
  NSString *familyName = valueDict[@"family_name"] ?: nil;
  NSString *givenName = valueDict[@"given_name"] ?: nil;
  NSString *email = valueDict[@"email"] ?: nil;
  NSNumber *emailVerified = valueDict[@"email_verified"] ?: nil;
  NSString *iss = valueDict[@"iss"] ?: @"";
  NSString *sub = valueDict[@"sub"] ?: @"";

  return [[DBOPENIDUserInfoResult alloc] initWithFamilyName:familyName
                                                  givenName:givenName
                                                      email:email
                                              emailVerified:emailVerified
                                                        iss:iss
                                                        sub:sub];
}

@end

#import "DBOPENIDAuthError.h"
#import "DBOPENIDErrUnion.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBOPENIDErrUnion

@synthesize authError = _authError;

#pragma mark - Constructors

- (instancetype)initWithAuthError:(DBOPENIDAuthError *)authError {
  self = [super init];
  if (self) {
    _tag = DBOPENIDErrUnionAuthError;
    _authError = authError;
  }
  return self;
}

- (instancetype)initWithOther {
  self = [super init];
  if (self) {
    _tag = DBOPENIDErrUnionOther;
  }
  return self;
}

#pragma mark - Instance field accessors

- (DBOPENIDAuthError *)authError {
  if (![self isAuthError]) {
    [NSException raise:@"IllegalStateException"
                format:@"Invalid tag: required DBOPENIDErrUnionAuthError, but was %@.", [self tagName]];
  }
  return _authError;
}

#pragma mark - Tag state methods

- (BOOL)isAuthError {
  return _tag == DBOPENIDErrUnionAuthError;
}

- (BOOL)isOther {
  return _tag == DBOPENIDErrUnionOther;
}

- (NSString *)tagName {
  switch (_tag) {
  case DBOPENIDErrUnionAuthError:
    return @"DBOPENIDErrUnionAuthError";
  case DBOPENIDErrUnionOther:
    return @"DBOPENIDErrUnionOther";
  }

  @throw([NSException exceptionWithName:@"InvalidTag" reason:@"Tag has an unknown value." userInfo:nil]);
}

#pragma mark - Serialization methods

+ (nullable NSDictionary<NSString *, id> *)serialize:(id)instance {
  return [DBOPENIDErrUnionSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary<NSString *, id> *)dict {
  return [DBOPENIDErrUnionSerializer deserialize:dict];
}

#pragma mark - Debug Description method

- (NSString *)debugDescription {
  return [[DBOPENIDErrUnionSerializer serialize:self] description];
}

#pragma mark - Copyable method

- (instancetype)copyWithZone:(NSZone *)zone {
#pragma unused(zone)
  /// object is immutable
  return self;
}

#pragma mark - Hash method

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;

  switch (_tag) {
  case DBOPENIDErrUnionAuthError:
    result = prime * result + [self.authError hash];
    break;
  case DBOPENIDErrUnionOther:
    result = prime * result + [[self tagName] hash];
    break;
  }

  return prime * result;
}

#pragma mark - Equality method

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![other isKindOfClass:[self class]]) {
    return NO;
  }
  return [self isEqualToErrUnion:other];
}

- (BOOL)isEqualToErrUnion:(DBOPENIDErrUnion *)anErrUnion {
  if (self == anErrUnion) {
    return YES;
  }
  if (self.tag != anErrUnion.tag) {
    return NO;
  }
  switch (_tag) {
  case DBOPENIDErrUnionAuthError:
    return [self.authError isEqual:anErrUnion.authError];
  case DBOPENIDErrUnionOther:
    return [[self tagName] isEqual:[anErrUnion tagName]];
  }
  return YES;
}

@end

#pragma mark - Serializer Object

@implementation DBOPENIDErrUnionSerializer

+ (NSDictionary<NSString *, id> *)serialize:(DBOPENIDErrUnion *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if ([valueObj isAuthError]) {
    jsonDict[@"auth_error"] = [[DBOPENIDAuthErrorSerializer serialize:valueObj.authError] mutableCopy];
    jsonDict[@".tag"] = @"auth_error";
  } else if ([valueObj isOther]) {
    jsonDict[@".tag"] = @"other";
  } else {
    jsonDict[@".tag"] = @"other";
  }

  return [jsonDict count] > 0 ? jsonDict : nil;
}

+ (DBOPENIDErrUnion *)deserialize:(NSDictionary<NSString *, id> *)valueDict {
  NSString *tag = valueDict[@".tag"];

  if ([tag isEqualToString:@"auth_error"]) {
    DBOPENIDAuthError *authError = [DBOPENIDAuthErrorSerializer deserialize:valueDict[@"auth_error"]];
    return [[DBOPENIDErrUnion alloc] initWithAuthError:authError];
  } else if ([tag isEqualToString:@"other"]) {
    return [[DBOPENIDErrUnion alloc] initWithOther];
  } else {
    return [[DBOPENIDErrUnion alloc] initWithOther];
  }
}

@end