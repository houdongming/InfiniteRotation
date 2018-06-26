//
//  SUTableViewInterceptor.m
//  GoldPigApp
//
//  Created by Office on 2018/4/3.
//  Copyright © 2018年 MiYIN.COM. All rights reserved.
//

#import "SUTableViewInterceptor.h"

@implementation SUTableViewInterceptor
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.middleMan respondsToSelector:aSelector]) return self.middleMan; if ([self.receiver respondsToSelector:aSelector]) return self.receiver; return [super forwardingTargetForSelector:aSelector];
    
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.middleMan respondsToSelector:aSelector]) return YES; if ([self.receiver respondsToSelector:aSelector]) return YES; return [super respondsToSelector:aSelector];
    
}

@end
