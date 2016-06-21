//
//  Person.m
//  OCBlock
//
//  Created by sseen on 16/6/21.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)str {
    self = [super self];
    if (self) {
        self.name = str;
    }
    return self;
}

@end
