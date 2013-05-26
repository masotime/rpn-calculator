//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Benjamin Goh on 26/5/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray* operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

// custom getter to avoid null issues
- (NSMutableArray *)operandStack
{
    // lazy instantiation / initialization. Note that it is "nil" and not "null"
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    // convert the double to an "object"
    NSNumber* operandObject = [NSNumber numberWithDouble:operand];
    
    // stuff it into the stack
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    // get the last object
    NSNumber* operandObject = [self.operandStack lastObject];
    
    // remove last object
    if (operandObject) [self.operandStack removeLastObject]; // removeLastObject won't crash if it is empty.
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString*)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        result = [self popOperand] - [self popOperand];
    } else if ([@"*" isEqualToString:operation]) { // this is special - reverse notation
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]) {
        result = [self popOperand] / [self popOperand];
    }
    
    [self pushOperand:result];
    
    // calculate result
    return result;
}

@end
