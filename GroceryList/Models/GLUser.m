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

- (void)fetch
{
  _items = nil;
  [super fetch];
}

- (NSArray *)items
{
  if (_items == nil) {
    PFQuery *query = [PFQuery queryWithClassName:[GLItem parseClassName]];
    [query whereKey:OWNER_KEY equalTo:self];
    _items = [[query findObjects] mutableCopy];
    NSLog(@"This user: %@ has %lu items", self.username, (unsigned long)_items.count);
    return _items;
  } else {
    return _items;
  }
}

- (void)addItem:(GLItem *)item {
  if (item) {
    item.owner = self;
    [item save];
    [self.items addObject:item];
  }
}

- (void)assignDefaultItems
{
  [self save];
  GLItem *item = [GLItem object];
  item.name = @"item 1";
  item.quanity = 1;
  item.checked = true;
  item.image = [UIImage imageNamed:@"item.jpeg"];
  [self addItem:item];

  GLItem *item2 = [GLItem object];
  item2.name = @"item 2";
  item2.quanity = 2;
  item2.checked = false;
  [self addItem:item2];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"User:%@ items:%@", self.username, self.items];
}

@end
