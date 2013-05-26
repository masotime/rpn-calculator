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

@end
