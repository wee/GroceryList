#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#define DEFAULT_USER @"user5"
#define DEFAULT_PASSWORD @"password"
#define DEFAULT_EMAIL DEFAULT_USER "@example.com"

@interface GLUser : PFUser<PFSubclassing>

+ (GLUser *)defaultUser;
+ (GLUser *)user;

@property (nonatomic, readonly) NSArray *items;

- (void)assignDefaultItems;

@end
