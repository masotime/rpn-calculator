//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Benjamin Goh on 26/5/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray* programStack; // not just operands.

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

// getter only for the program - satisfy the read only
- (id)program
{
    // we return a copy - don't allow internal state to be exposed. note this is immutable
    return [self.programStack copy];
}

//description
+ (NSString*)descriptionOfProgram:(id)program
{
    return @"Hello world";
}

+ (double)popOperandOffStack:(NSMutableArray*)stack
{
    double result = 0;
    
    // we are very nil safe :)
    id topOfStack = [stack lastObject]; // call the message "lastObject". why id? it could be a number or a string. we don't know.
    if (topOfStack) [stack removeLastObject]; // call the message "removeLastObject" - so we remove an object only if it exists.
    
    // do different stuff depending on the type of object popped off the stack
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue]; // convert to primitve
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString* operation = topOfStack;
        double rightHand = [self popOperandOffStack:stack];
        double leftHand = [self popOperandOffStack:stack];
        
        if ([operation isEqualToString:@"+"]) {
            result = leftHand + rightHand;
        } else if ([operation isEqualToString:@"*"]) {
            result = leftHand * rightHand;
        } else if ([operation isEqualToString:@"-"]) {
            result = leftHand - rightHand;
        } else if ([operation isEqualToString:@"/"]) {
            if (rightHand) result = leftHand / rightHand; // division by zero check
        }
    }
    
    // because there are only checks for numbers and strings, other objects will return nil / 0, so the universe is safe.
    // hooray!
    return result;
}

+ (double)runProgram:(id)program
{
    // passed as an immutable array. we need to transform it to something mutable.
    // also, we need to use introspection to protect against unknown objects being passed in
    // (check if it is an array)
    
    NSMutableArray* stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy]; // i make a mutable copy of the array passed in. note that it doesn't complain of typecasting problems
    }
    
    return [self popOperandOffStack:stack]; // call the recursion. if it is not an array this will just return nil.
}


// custom getter to avoid null issues
- (NSMutableArray *)programStack
{
    // lazy instantiation / initialization. Note that it is "nil" and not "null"
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    
    return _programStack;
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString*)operation
{
    // i will push the operation into the stack
    [self.programStack addObject:operation];
    
    // we let the program run the operation
    return [CalculatorBrain runProgram:self.program];

}

@end
