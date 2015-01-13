#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "GLUser.h"

@interface GLUserTest : XCTestCase
@property (nonatomic) GLUser *user;
@end

@implementation GLUserTest

- (void)setUp
{
  [super setUp];
  self.user = [GLUser user];
}

- (void)tearDown
{
  [super tearDown];
  self.user = nil;
}

//- (void)testSaveIsSuccessful
//{
//  self.user.username = @"test user name";
//  self.user.password = @"testpassword";
//  XCTAssertTrue([self.user save]);
//
//  self.user = nil;
//}

@end
