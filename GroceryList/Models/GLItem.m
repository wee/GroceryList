#import "GLItem.h"

#import <Parse/PFObject+Subclass.h>

#define IMAGE_CLASS_NAME @"ItemPhoto"
#define IMAGE_FILE_KEY @"imageFile"

@implementation GLItem

@dynamic name;
@dynamic quanity;
@dynamic checked;
@dynamic owner;
@synthesize image=_image;

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
  if (self.owner) {
    [self setObject:self.owner forKey:OWNER_KEY];
    PFACL *acl = [PFACL ACLWithUser:(PFUser *)self.owner];
    [acl setPublicReadAccess:YES];
    [self setACL:acl];
  }
  return [super save];
}

- (void)setImage:(UIImage *)image
{
  _image = image;
  [self uploadImage];
}

- (UIImage *)image
{
  if (_image == nil) {
    PFQuery *query = [PFQuery queryWithClassName:IMAGE_CLASS_NAME];
    [query whereKey:OWNER_KEY equalTo:self];
    NSArray *result = [query findObjects];
    if (result.count > 0) {
      PFObject *imageObject = result[0];
      PFFile *imageFile = [imageObject objectForKey:IMAGE_FILE_KEY];
      NSData *imageData = [imageFile getData];
      _image = [UIImage imageWithData:imageData];
      NSLog(@"Setting image for item: %@ size:%lu", self.name, imageData.length);
    } else {
      NSLog(@"Cannot find image for this item: %@", self.name);
    }
  }
  return _image;
}

- (void)uploadImage
{
  if (_image) {
    [self save];
    NSData *imageData = UIImageJPEGRepresentation(self.image, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      PFObject *itemPhoto = [PFObject objectWithClassName:IMAGE_CLASS_NAME];
      [itemPhoto setObject:imageFile forKey:IMAGE_FILE_KEY];
      itemPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
      [itemPhoto setObject:self forKey:OWNER_KEY];
      [itemPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
          NSLog(@"Photo saved");
        } else {
          NSLog(@"Photo saved error: %@", [error userInfo]);
        }
      }];
    }];
  }
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Item: %@ quanity: %lu checked:%d hasImage:%d",
          self.name, self.quanity, self.checked, self.image != nil];
}

@end
