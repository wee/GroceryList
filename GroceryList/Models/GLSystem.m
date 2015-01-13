#import "GLSystem.h"
#import "GLUser.h"

@implementation GLSystem

- (instancetype)initWithOptions:(NSDictionary *)options
{
  if (self = [super init]) {
    [self initParse:options];
    [self setup];
  }
  return self;
}

- (void)loginUser:(GLUser *)user withBlock:(void (^)(GLUser *))block
{
  [PFUser logInWithUsernameInBackground:user.username password:user.password
                                  block:^(PFUser *user, NSError *error) {
                                    if (user) {
                                      self.user = (GLUser *)user;
                                      NSLog(@"Found user: %@", user);
                                      block(self.user);
                                    } else {
                                      block(nil);
                                    }
                                  }];
}

- (void)addNewUser:(GLUser *)user withBlock:(void (^)(GLUser *))block
{
  [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (!error) {
      block(user);
    } else {
      block(nil);
    }
  }];
}

#pragma mark - private methods

- (void)initParse:(NSDictionary *)launchOptions
{
  [Parse enableLocalDatastore];
  [Parse setApplicationId:@"UgXTMmc18BJI2LqRtxMvy8E0OyCYMufRGZc1qGRs"
                clientKey:@"Hbs7J2fqf0Sp2l16xEttIJ0uNNCEnIeeNe1baFTZ"];

  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

- (void)setup
{
  GLUser *user = [GLUser defaultUser];
  [self loginUser:user withBlock:^(GLUser *loggedinUser) {
    if (loggedinUser) {
      self.user = (GLUser *)loggedinUser;
      NSLog(@"Found user: %@", loggedinUser);
    } else {
      self.user = [self userSignupWithDefault];
      NSLog(@"New user:%@", user);
    }
  }];
}

- (GLUser *)userSignupWithDefault
{
  GLUser *user = (GLUser *)[GLUser user];
  user.username = DEFAULT_USER;
  user.password = DEFAULT_PASSWORD;
  user.email = DEFAULT_EMAIL;
  [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (!error) {
      NSLog(@"Creating default user is successful. User: %@", user);
      [user assignDefaultItems];
    } else {
      NSLog(@"Error while creating the default user: %@", [error userInfo][@"error"]);
    }
  }];
  return user;
}

@end
