
#import "MainVC.h"
#import "LoginVC.h"
#import "TableViewController.h"
#import "FMDatabase.h"


@interface MainVC ()
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self errorLabel] setTextColor:[UIColor redColor]];
    [[self errorLabel] setText:@""];
    [[self loginLabel] setText:@"Login"];
    [[self passwordLabel] setText:@"Password"];
    [[self loginButton] setTitle:@"Login" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMap:(id)sender {
    LoginVC* lvc = [LoginVC new];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    [[self errorLabel] setText:@""];
    
    NSString* name = [[self loginTextField] text];
    NSString* pass = [[self passwordTextField] text];
    NSString* query = @"SELECT * FROM user WHERE login=\"";
    query = [[query stringByAppendingString:name] stringByAppendingString:@"\""];
    NSInteger userId;
    
    FMDatabase* db = [FMDatabase databaseWithPath:@"/Users/admin/Downloads/tp9/DreamInvestBank/tp9.db"];
       if(![db open]) {
        [[self errorLabel] setText:@"DB error."];
        return;
    }
    
    FMResultSet* rs = [db executeQuery:query];
    
    if([rs next]) {
        NSString* rightPass = [rs stringForColumn:@"password"];
        userId = [rs intForColumn:@"id"];
        if([pass isEqualToString:rightPass]) {
            TableViewController *mvc = [TableViewController new];
            [mvc setUserId:userId];
            [self presentViewController:mvc animated:YES completion:nil];
        }
        else {
            [[self errorLabel] setText:@"Wrong password."];
        }
    }
    else {
        [[self errorLabel] setText:@"No such user"];
    }
    [db close];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
