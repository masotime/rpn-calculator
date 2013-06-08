//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Benjamin Goh on 26/5/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString*)operation;

// this is readonly - can only "get" the program
@property (readonly) id program; // avoid introducing a whole other class - so just generic id. "future compatibility"

+ (double) runProgram:(id)program; // "static" method. return double if last item in stack is operation. Don't need an instance of CalculatorBrain to run the program.
+ (NSString*) descriptionOfProgram:(id)program;

@end