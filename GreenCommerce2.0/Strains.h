//
//  Strains.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 11/3/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Strains : NSObject
@property (nonatomic, readonly) NSString *Name;
@property (nonatomic, readonly) NSString *Image;
@property (nonatomic, readonly) NSString *URL;
@property (nonatomic, readonly) NSString *UCPC;
- (instancetype)initWithJSON:(NSDictionary*)json;

@end
