//
//  BNRTextFunction.m
//  Textra
//
//  Created by Owen Mathews on 9/16/13.
//  Copyright (c) 2013 Owen Mathews. All rights reserved.
//

#import "BNRTextFunction.h"

@interface BNRTextFunction ()

@property (nonatomic, copy) NSString *body;
@property (nonatomic) JSValue *function;
@property (nonatomic, weak) JSContext *context;

@end

@implementation BNRTextFunction

- (id)init {
    return [self initWithName:nil body:nil];
}

- (id)initWithName:(NSString *)name body:(NSString *)body {
    self = [super init];
    if (self) {
        [self setName:name body:body];
    }
    return self;
}

- (void)setName:(NSString *)name body:(NSString *)body {
    if (!body)
        body = @"";
    _body = [body copy];
    
    if (!name) {
        self.function = nil;
        return;
    }
    _name = [name copy];
    
    [self validateFunction];
}

- (void)validateFunction {
    if (self.context) {
        NSMutableString *script = [NSMutableString string];
        [script appendFormat:@"var %@ = function(input) {\n", self.name];
        [script appendFormat:@"%@\n};", self.body];

        JSStringRef scriptRef = JSStringCreateWithCFString((__bridge CFStringRef)script);
        BOOL validScript = JSCheckScriptSyntax([self.context JSGlobalContextRef], scriptRef, NULL, 0, NULL);
        if (!validScript) {
            self.function = nil;
        } else {
            [self.context evaluateScript:script];
            self.function = self.context[self.name];
            JSObjectRef functionObject = JSValueToObject([self.context JSGlobalContextRef], [self.function JSValueRef], NULL);
            BOOL validFunction = NO;
            if (functionObject) {
                validFunction = JSObjectIsFunction([self.context JSGlobalContextRef], functionObject);
            }
            if (!validFunction) {
                self.function = nil;
            }
        }
    }
}

- (BOOL)isValid {
    return _function != nil;
}

- (void)installInContext:(JSContext *)context {
    self.context = context;
    
    if (!self.context) {
        self.function = nil;
    } else if (!self.function) {
        [self validateFunction];
    }
}

- (NSString *)evaluateWithInput:(NSString *)input {
    NSString *result = input;
    if (self.function && input) {
        JSValue *resultValue = [self.function callWithArguments:@[input]];
        if ([resultValue isString]) {
            result = [resultValue toString];
        }
    }
    return result;
}

@end
