//
//  Strains.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 11/3/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "Strains.h"

@implementation Strains
-(instancetype)initWithJSON:(NSDictionary *)json{
    self = [super init];
    if (self) {
        _Name = [json objectForKey:@"name"];
        _Image =[json objectForKey:@"image"];
        _URL = [json objectForKey:@"url"];
        _UCPC = [json objectForKey:@"_ucpc"];
        
    }
    return self;
    
}
@end
