//
//  RegisterViewController.m
//  
//
//  Created by Jack on 2014-10-04.
//
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "WelcomeViewController.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface RegisterViewController ()

@property (nonatomic, strong) NSMutableArray *nameTitleArray;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTitleArray = [[NSMutableArray alloc] initWithObjects:@"Name",@"Address",@"Phone",@"Email",@"Card",nil];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    self.navigationController.navigationBar.barTintColor = RGB(238, 220, 137);
//    [self.navigationController.navigationItem.leftBarButtonItems[0] setTintColor:RGB(194, 121, 63)];
    [self.cancelButton setTintColor:RGB(194, 121, 63)];
    [self.saveButton setTintColor:RGB(194, 121, 63)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.nameTitleArray count];    //count number of row from counting array hear cataGorry is An Array
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Account";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    RegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[RegisterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.placeHolder = [self.nameTitleArray objectAtIndex:indexPath.row];
    cell.indexPath = indexPath;
    [cell setIcon];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isRegistered = [defaults objectForKey:@"isRegistered"];
    
    if (isRegistered) {
        
        NSMutableArray *customerInfo = [defaults objectForKey:@"customerInfo"];
        NSString *content = [customerInfo objectAtIndex:indexPath.row];
        cell.inputTextField.text = content;
        
    } else {
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@""]];
        [defaults setObject:array forKey:@"customerInfo"];
        
    }
    
    return cell;
}

- (IBAction)cancelEvent:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)saveEvent:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isRegistered"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view resignFirstResponder];
}

-(void) hideKeyboard {
    
    [self.view resignFirstResponder];
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
