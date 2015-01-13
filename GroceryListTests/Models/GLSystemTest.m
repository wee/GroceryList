#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GLSystem.h"
#import "GLUser.h"
#import "AppDelegate.h"

@interface GLSystemTest : XCTestCase

@property (nonatomic) GLSystem *system;

@end

@implementation GLSystemTest

- (void)setUp {
  [super setUp];
  AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  self.system = app.system;
}

- (void)tearDown {
  self.system = nil;
  [super tearDown];
}

- (void)testSystemHasDefaultUser {
  GLUser *user = [GLUser defaultUser];
  [self.system loginUser:user withBlock:^(GLUser *user) {
    XCTAssertNil(user);
  }];
}

- (void)testAddUser {
  GLUser *user = [GLUser user];
  user.username = @"testuser";
  user.password = @"testpassword";
  user.email = @"testemail@example.com";
  __block GLSystemTest *weakSelf = self;
  [weakSelf.system addNewUser:user withBlock:^(GLUser *savedUser) {
    XCTAssertNotNil(savedUser);
  }];
}

@end
