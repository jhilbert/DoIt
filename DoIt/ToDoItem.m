//
//  ToDoItem.m
//  DoIt
//
//  Created by Josef Hilbert on 13.01.14.
//  Copyright (c) 2014 Josef Hilbert. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

-(id)initWithString:(NSString*)string
{
    _text = string;
    _color = [UIColor blackColor];
    
    return self;
}


@end
