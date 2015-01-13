#import "FirstViewController.h"

#import <Parse/Parse.h>
#import "GLUser.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemsLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  GLUser *user = [GLUser currentUser];
  self.userLabel.text = user.username;
  self.itemsLabel.text = [NSString stringWithFormat:@"has %lu items: %@", user.items.count, user.items];
}

@end
