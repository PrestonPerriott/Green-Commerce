//
//  GreenRequestHandler.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 11/2/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "GreenRequestHandler.h"
#import "Strains.h"
#import "Dispensary.h"
#import "AFNetworking.h"




@implementation GreenRequestHandler
+ (GreenRequestHandler *)sharedHandler {
    
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
    
}
-(void)getStrains{
    
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:@"https://www.cannabisreports.com/api/v1.0/strains?sort=name&page=1"] completionHandler:^(NSData * _Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error){
        if (error) {
            if ([_delegate respondsToSelector:@selector(requestHandler:didNotGetStrainsWithError:)])    [_delegate requestHandler:self didNotGetStrainsWithError:[[NSError alloc]initWithDomain:@"error.ripta.api" code:9 userInfo:@{
                                                                                                                                                                                                                                  NSLocalizedDescriptionKey :
                                                                                                                                                                                                                                      @"Network connection not found",
                                                                                                                                                                                                                                  }] ];
        
            }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            if ([_delegate respondsToSelector:@selector(requestHandler:didNotGetStrainsWithError:)]) [_delegate requestHandler:self didNotGetStrainsWithError:[[NSError alloc] initWithDomain:@"error.ripta.api" code:9 userInfo:@{
                                                                                                                                                                                                                                   NSLocalizedDescriptionKey : @"JSON could not decrypt",
                                                                                                                                                                                                                                   }]];}
        
        NSMutableArray *strainsArray = [NSMutableArray new];
        for (NSDictionary *dataObject in json[@"data"]) {
            Strains *strain = [[Strains alloc]initWithJSON:dataObject];
            [strainsArray addObject:strain];
        }
        if ([_delegate respondsToSelector:@selector(requestHandler:didGetStrains:)]) [_delegate requestHandler:self didGetStrains:strainsArray];} ] resume];
}


-(void)GetStrainsWithPageNum:(int)pageNum{
    
    
    
    
    NSString *url = @"https://www.cannabisreports.com/api/v1.0/strains?sort=name&page=";
    
    NSString *numberfied = [NSString stringWithFormat:@"%d", pageNum];
    NSLog(@"Numberfied : %@ ", numberfied);
    
    NSString *fullString = [url stringByAppendingString:numberfied];
    NSLog(@"Fullstring : %@", fullString);
    
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:fullString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        //Checks if JSOn is array or dictionary
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSLog(@"Array : %@", responseObject);
            NSMutableArray *strainsArray = [NSMutableArray new];
            for (NSDictionary *dataObject in responseObject[@"data"]) {
                Strains *strain = [[Strains alloc]initWithJSON:dataObject];
                [strainsArray addObject:strain];
            }
            if ([_delegate respondsToSelector:@selector(requestHandler:didGetStrainsWithPageNum:)]) [_delegate requestHandler:self didGetStrainsWithPageNum:strainsArray];
            
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
            
            
            NSLog(@"Dictionary : %@", responseObject);
            NSMutableArray *strainsArray = [NSMutableArray new];
            for (NSDictionary *dataObject in responseObject[@"data"]) {
                Strains *strain = [[Strains alloc]initWithJSON:dataObject];
                [strainsArray addObject:strain];
            }
            if ([_delegate respondsToSelector:@selector(requestHandler:didGetStrainsWithPageNum:)]) [_delegate requestHandler:self didGetStrainsWithPageNum:strainsArray];
            
        }
        
    }failure:^(NSURLSessionTask *task, NSError *error){
        NSLog(@"The error is : %@", error);
    }
     ];
    
        
  /*  [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:fullString] completionHandler:^(NSData * _Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error){
        if (error) {
            if ([_delegate respondsToSelector:@selector(requestHandler:didNotGetStrainsWithError:)]) [_delegate requestHandler:self didNotGetStrainsWithError:[[NSError alloc]initWithDomain:@"error.ripta.api" code:9 userInfo:@{
                                                                                                                                                                                                                                  NSLocalizedDescriptionKey :
                                                                                                                                                                                                                                      @"Network connection not found",
                                                                                                                                                                                                                                  }] ];
            
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            if ([_delegate respondsToSelector:@selector(requestHandler:didNotGetStrainsWithError:)]) [_delegate requestHandler:self didNotGetStrainsWithError:[[NSError alloc] initWithDomain:@"error.ripta.api" code:9 userInfo:@{
                                                                                                                                                                                                                                   NSLocalizedDescriptionKey : @"JSON could not decrypt",
                                                                                                                                                                                                                                   }]];}
        
        NSMutableArray *strainsArray = [NSMutableArray new];
        for (NSDictionary *dataObject in json[@"data"]) {
            Strains *strain = [[Strains alloc]initWithJSON:dataObject];
            [strainsArray addObject:strain];
        }
        if ([_delegate respondsToSelector:@selector(requestHandler:didGetStrainsWithPageNum:)]) [_delegate requestHandler:self didGetStrainsWithPageNum:strainsArray];} ] resume];
    
    
  */  
}


@end
