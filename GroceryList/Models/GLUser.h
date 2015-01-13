#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#define DEFAULT_USER @"user5"
#define DEFAULT_PASSWORD @"password"
#define DEFAULT_EMAIL DEFAULT_USER "@example.com"

@interface GLUser : PFUser<PFSubclassing>

// Create a user object with default name, password, email
+ (GLUser *)defaultUser;
// Create a new empty user object
+ (GLUser *)user;
// Return the current logged in user or nil
+ (GLUser *)currentUser;

@property (nonatomic, readonly) NSArray *items;

- (void)assignDefaultItems;

@end
