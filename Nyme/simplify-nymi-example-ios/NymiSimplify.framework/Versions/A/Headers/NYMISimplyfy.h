//
//  NYMISimplyfy.h
//  Unified
//
//  Created by Prasannaa Santhanam on 9/19/14.
//
//

#import <Foundation/Foundation.h>


@protocol NymiSimplifyListener <NSObject>

-(void) onUpdates:(NSString*) msg;

-(void) onReceivedError:(int) errorCode error:(NSError*) error;

-(void) onPaymentSucessful:(NSString*) response;

@end


@interface NymiSimplify : NSObject

@property(nonatomic, assign) BOOL enableLogs;

-(void) discoverNymi:(id<NymiSimplifyListener>) delegate withIp:(NSString*) nymulatorIp;


@end
