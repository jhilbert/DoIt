//
//  ToDoItem.h
//  DoIt
//
//  Created by Josef Hilbert on 13.01.14.
//  Copyright (c) 2014 Josef Hilbert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic) NSString *text;
@property (nonatomic) UIColor *color;

-(id)initWithString:(NSString*)string;

@end
