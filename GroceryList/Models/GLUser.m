#import "GLUser.h"

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "GLItem.h"

@implementation GLUser

@synthesize items = _items;

+ (void)load
{
  [self registerSubclass];
}

// Create a user instance with predefined info
+ (GLUser *)defaultUser
{
  GLUser *user = [GLUser user];
  user.username = DEFAULT_USER;
  user.password = DEFAULT_PASSWORD;
  user.email = DEFAULT_EMAIL;
  return user;
}

// Create a new user instance
+ (GLUser *)user
{
  return [GLUser object];
}

+ (GLUser *)currentUser
{
  return (GLUser *)[PFUser currentUser];
}

- (NSArray *)items
{
  if (_items == nil) {
    PFQuery *query = [PFQuery queryWithClassName:[GLItem parseClassName]];
    [query whereKey:OWNER_KEY equalTo:self];
    NSArray *result = [query findObjects];
    NSLog(@"This user: %@ has %lu items", self.username, (unsigned long)result.count);
    return result;
  } else {
    return _items;
  }
}


- (void)assignDefaultItems
{
  [self save];
  GLItem *item = [GLItem object];
  item.name = @"item 1";
  item.quanity = 1;
  item.checked = true;
  item.owner = self;
  [item save];

  GLItem *item2 = [GLItem object];
  item2.name = @"item 2";
  item2.quanity = 2;
  item2.checked = false;
  item2.owner = self;
  [item2 save];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"User:%@ items:%@", self.username, self.items];
}

@end
