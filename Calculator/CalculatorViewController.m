//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Benjamin Goh on 26/5/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
    // space for private stuff
    @property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

    // pointer to the model
    @property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain * )brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

// ALL copy/pasted buttons call the same "target"
- (IBAction)digitPressed:(UIButton *)sender // again, IBAction return typedef void - another XCode thing
{
    // sender is the button
    // id - very important type - primitive type - pointer to ANY kind of object - pointer to "Unknown class".
    
    // find out from the sender which putton is pressed
    NSString* digit = [sender currentTitle]; // pointer or copy? - this is probably a copy
    
    /* Longer version */
    /*
    NSLog(@"digit pressed = %@", digit); // @" constant NS String. %@ - object
    
    UILabel* myDisplay = [self display]; // getter for display.
    myDisplay = self.display; // alternate syntax
    
    NSString* currentText = myDisplay.text; // [myDisplay text]
    NSString* newText = [currentText stringByAppendingString:digit]; // appends digit. += digit
    [myDisplay setText:newText]; // transfer the concatenated string to the display
    myDisplay.text = newText; // doing it again, but with dot notation
    */
    
    // or to summarise
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit]; // can't use dot notation on stringByAppendingString method?
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES; // so after the first digit then it starts appending
    }
    
}

- (IBAction)operationPressed:(UIButton*) sender {

    // if the user was typing a number, convenience - auto call an "ENTER" - note that I call the handler
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    // let the model do the calculation
    double result = [self.brain performOperation:[sender currentTitle]];
    
    // format the result into a string
    NSString* resultString = [NSString stringWithFormat:@"%g", result]; // how come there is a comma?
    
    // dumdedum
    self.display.text = resultString;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]]; // convert to double
    self.userIsInTheMiddleOfEnteringANumber = NO; // reset the state
}

// lets ignore this for now
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
