//
//  BNRTextFunction.h
//  Textra
//
//  Created by Owen Mathews on 9/16/13.
//  Copyright (c) 2013 Owen Mathews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRTextFunction : NSObject

- (id)initWithName:(NSString *)name body:(NSString *)body;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) BOOL isValid;
@property (nonatomic, copy, readonly) NSString *body;

- (void)installInContext:(JSContext *)context;

- (void)setName:(NSString *)name body:(NSString *)body;
- (NSString *)evaluateWithInput:(NSString *)input;

@end
