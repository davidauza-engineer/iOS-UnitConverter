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
// Bad input
// UI when changing values in textInput
// Format output

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;

@property (weak, nonatomic) IBOutlet UILabel *outputField;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation ViewController

// This method converts seconds to milliseconds
- (double)convertSecondsToMilliseconds:(double)seconds {
    double milliseconds = seconds * 1000;
    return milliseconds;
}

// This method converts seconds to minutes
- (double)convertSecondsToMinutes:(double)seconds {
    double minutes = seconds / 60;
    return minutes;
}

// This method converts minutes to hours
- (double)convertMinutesToHours:(double)minutes {
    double hours = minutes / 60;
    return hours;
}

- (IBAction)updateButton:(id)sender {
    NSMutableString *buf = [[NSMutableString alloc] init];
    double userInput = [self.inputField.text doubleValue];
    NSInteger segmentControllerIndex = self.segmentController.selectedSegmentIndex;
    if (segmentControllerIndex == 0) {
        double unitTwoValue = [self convertSecondsToMilliseconds:userInput];
        [buf appendString:[@(unitTwoValue) stringValue]];
    } else if (segmentControllerIndex == 1) {
        double unitTwoValue = [self convertSecondsToMinutes:userInput];
        [buf appendString:[@(unitTwoValue) stringValue]];
    } else {
        double unitTwoValue = [self convertSecondsToMinutes:userInput];
        unitTwoValue = [self convertMinutesToHours:unitTwoValue];
        [buf appendString:[@(unitTwoValue) stringValue]];
    }
    self.outputField.text = buf;
}

// This method is executed once the user presses the send button in the beyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Hide keyboard
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputField.delegate = self;
    // Set send button 
    [self.inputField setReturnKeyType:UIReturnKeySend];
}


@end
