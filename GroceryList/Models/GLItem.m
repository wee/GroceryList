#import "GLItem.h"

#import <Parse/PFObject+Subclass.h>

@implementation GLItem

@dynamic name;
@dynamic quanity;
@dynamic checked;
@dynamic owner;

+ (void)load
{
  [self registerSubclass];
}

+ (NSString *)parseClassName
{
  return @"item";
}

- (BOOL)save
{
  [self setObject:self.owner forKey:OWNER_KEY];
  PFACL *acl = [PFACL ACLWithUser:(PFUser *)self.owner];
  [acl setPublicReadAccess:YES];
  [self setACL:acl];
  return [super save];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Item: %@ quanity: %lu checked:%d", self.name, self.quanity, self.checked];
}

@end
