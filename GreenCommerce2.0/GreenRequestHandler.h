//
//  GreenRequestHandler.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 11/2/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Strains, GreenRequestHandler, Dispensary;
@protocol GreenRequestHandlerDelegate <NSObject>
@optional

-(void)requestHandler:(GreenRequestHandler*)request didGetStrains:(NSArray <Strains*> *)strains;
-(void)requestHandler:(GreenRequestHandler *)request didGetStrainsWithPageNum:(NSArray <Strains*>*)strains;
-(void)requestHandler:(GreenRequestHandler *)request didNotGetStrainsWithError:(NSError*)error;
-(void)requestHandler:(GreenRequestHandler *)request didGetDispensaries:(NSArray <Dispensary*> *)dispensary;

@end

@interface GreenRequestHandler : NSObject
@property (nonatomic, retain) id<GreenRequestHandlerDelegate> delegate;

+ (GreenRequestHandler*)sharedHandler;
- (void)getStrains;
- (void)GetStrainsWithPageNum:(int)pageNum;
-(void)GetDispensary;

@end
