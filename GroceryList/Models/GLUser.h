#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#define DEFAULT_USER @"user26"
#define DEFAULT_PASSWORD @"password"
#define DEFAULT_EMAIL DEFAULT_USER "@example.com"

@class GLItem;

@interface GLUser : PFUser<PFSubclassing>

// Create a user object with default name, password, email
+ (GLUser *)defaultUser;
// Create a new empty user object
+ (GLUser *)user;
// Return the current logged in user or nil
+ (GLUser *)currentUser;

@property (nonatomic) NSMutableArray *items;

- (void)fetch;
- (void)addItem:(GLItem *)item;
- (void)assignDefaultItems;

@end
