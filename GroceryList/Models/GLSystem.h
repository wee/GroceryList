#import <Foundation/Foundation.h>

@class GLUser;

@interface GLSystem : NSObject

@property (nonatomic) GLUser *user;

- (instancetype)initWithOptions:(NSDictionary *)options;
- (void)loginUser:(GLUser *)user withBlock:(void (^)(GLUser *))block;
- (void)addNewUser:(GLUser *)user withBlock:(void (^)(GLUser *))block;

@end
