//
//  NSString+HTMLParse.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/25/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

//Category that adds a specfic function to the NSSTRing class
//Unlike a subclass you will never ovveride a functon here 

#import "NSString+HTMLParse.h"

@implementation NSString (HTMLParse)


-(NSString *) stringByStrippingHTML{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


@end
