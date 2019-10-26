//
//  ViewController.m
//  UnitConverter
//
//  Created by David Auza on 19/10/19.
//  Copyright © 2019 David Auza. All rights reserved.
//

#import "ViewController.h"

// TODO
// Optionally: Add reset button.
// Bad input
// UI when changing values in textInput
// hide keyboard when touching outside
// automatically update when selecting the segemented controller

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;

@property (weak, nonatomic) IBOutlet UILabel *outputField;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation ViewController

// This method converts seconds to milliseconds.
- (double)convertSecondsToMilliseconds:(double)seconds {
    double milliseconds = seconds * 1000;
    return milliseconds;
}

// This method converts seconds to minutes.
- (double)convertSecondsToMinutes:(double)seconds {
    double minutes = seconds / 60;
    return minutes;
}

// This method converts seconds to hours
- (double)convertSecondsToHours:(double)seconds {
    double hours = seconds / 3600;
    return hours;
}

// This method formats the output like: 1,000 for integers and 1,000.25 for doubles
- (NSMutableString *)formatOutput:(double)unitValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setMinimumFractionDigits:0];
    [formatter setMaximumFractionDigits:4];
    [formatter setDecimalSeparator:@"."];
    NSMutableString *result = [[formatter stringFromNumber:[NSNumber numberWithDouble:unitValue]] mutableCopy];
    return result;
}

// This method is executed once the user presses the update button.
- (IBAction)updateButton:(id)sender {
    NSMutableString *output = [[NSMutableString alloc] init];
    double userInput = [self.inputField.text doubleValue];
    NSInteger segmentControllerIndex = self.segmentController.selectedSegmentIndex;
    switch (segmentControllerIndex) {
        case 0:
        {
            double unitTwoValue = [self convertSecondsToMilliseconds:userInput];
            output = [self formatOutput:unitTwoValue];
            break;
        }
        case 1:
        {
            double unitThreeValue = [self convertSecondsToMinutes:userInput];
            output = [self formatOutput:unitThreeValue];
            break;
        }
        default:
        {
            double unitFourValue = [self convertSecondsToHours:userInput];
            output = [self formatOutput:unitFourValue];
            break;
        }
    }
    self.outputField.text = output;
    [self hideKeyboard];
}

// This method hides the keyboard in case it is open
- (void)hideKeyboard {
    if ([self.inputField isFirstResponder]) {
        [self.inputField resignFirstResponder];
    }
}

// This method is executed once the user presses the send button in the beyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Hide keyboard
    [self hideKeyboard];
    return YES;
}

// This method returns the view to its initial state
- (IBAction)resetView:(id)sender {
    self.inputField.text = @"";
    if (self.segmentController.selectedSegmentIndex != 0) {
        self.segmentController.selectedSegmentIndex = 0;
    }
    self.outputField.text = @"Click Update to Convert!";
}

// This method is executed after loading the View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputField.delegate = self;
    // Set send button 
    [self.inputField setReturnKeyType:UIReturnKeySend];
}


@end
