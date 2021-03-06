//
//  MERZip.m
//  MEReactiveFoundation
//
//  Created by William Towe on 1/24/14.
//  Copyright (c) 2014 Maestro, LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MERZip.h"
#import "MERFold.h"

id MERZip(id<NSObject,NSFastEnumeration> collection) {
    if ([collection isKindOfClass:[NSArray class]]) {
        NSMutableArray *retval = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)collection;
        NSUInteger count = [MERFoldLeft(array, @(NSNotFound), ^id(NSNumber *accumulator, NSArray *value, BOOL *stop) {
            return @(accumulator.unsignedIntegerValue > value.count ? value.count : accumulator.unsignedIntegerValue);
        }) unsignedIntegerValue];

        for (NSUInteger i=0; i<count; i++) {
            NSArray *zippedArray = MERFoldLeft(array, [[NSMutableArray alloc] init], ^id(NSMutableArray *accumulator, NSArray *value, BOOL *stop) {
                [accumulator addObject:value[i]];
                
                return accumulator;
            });
            
            [retval addObject:zippedArray];
        }
        
        return retval;
    }
    return nil;
}
