//
//  ViewController.m
//  UnitConverter
//
//  Created by David Auza on 19/10/19.
//  Copyright © 2019 David Auza. All rights reserved.
//

#import "ViewController.h"

// TODO use Objective-C methods and a Switch structure for updateButton method
// Optionally: Add reset button.
// Check the right way to write the textFieldShouldReturn logic
// Change the intro button to blue 

double convertUnitOneToUnitTwo(double unitOneValue) {
    double unitTwoValue;
    unitTwoValue = (10 * unitOneValue) + 2;
    return unitTwoValue;
}

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;

@property (weak, nonatomic) IBOutlet UILabel *outputField;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation ViewController

- (IBAction)updateButton:(id)sender {
    NSMutableString *buf = [[NSMutableString alloc] init];
    double userInput = [self.inputField.text doubleValue];
    NSInteger segmentControllerIndex = self.segmentController.selectedSegmentIndex;
    if (segmentControllerIndex == 0) {
        double unitTwoValue = convertUnitOneToUnitTwo(userInput);
        [buf appendString:[@(unitTwoValue) stringValue]];
    } else if (segmentControllerIndex == 1) {
        [buf appendString:@"unit three"];
    } else {
        [buf appendString:@"unit four"];
    }
    self.outputField.text = buf;
    // Hide keyboard
    [self.view endEditing:YES];
}

// This method is executed once the user presses the intro button in the beyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    // call the updateButton method to automatically execute the conversion
    [self updateButton:self.actionButton];
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputField.delegate = self;
}


@end
