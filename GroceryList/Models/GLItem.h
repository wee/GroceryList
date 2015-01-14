#import <Parse/Parse.h>

#define OWNER_KEY @"owner"

@class GLUser;

@interface GLItem : PFObject<PFSubclassing>

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger quanity;
@property (nonatomic) BOOL checked;
@property (nonatomic) UIImage *image;
@property (nonatomic) GLUser *owner;

+ (NSString *)parseClassName;

@end
