//
//  PageNavigationInterceptor.m
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "PageNavigationInterceptor.h"
#import "Aspects.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface PageNavigationInterceptor ()
@property (nonatomic) id<AspectToken> token;
@end

@implementation PageNavigationInterceptor

//- (void)relaceOriginalPage:(NSString *)originalPageClassName withNewPage:(NSString *)newPageClassName {
//    Class originalClass = NSClassFromString(originalPageClassName);
//    __weak PageNavigationInterceptor* weakSelf = self;
//    id<AspectToken> token1 = [originalClass aspect_hookSelector:@selector(initWithDic:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, NSMutableDictionary *dic) {
//        weakSelf.orginDic = dic;
//        NSInvocation *invocation = [aspectInfo originalInvocation];
//        [invocation.superclass forwardInvocation:invocation];
//    } error:NULL];
//    
//    id<AspectToken> token2 = [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, UIViewController *originalController, BOOL animated) {
//        NSInvocation *invocation = [aspectInfo originalInvocation];
//        Class newPageClass = NSClassFromString(newPageClassName);
//        if ([originalController isMemberOfClass:originalClass]) {
//            id newPageInstance = [newPageClass alloc];
//            newPageInstance = [newPageInstance performSelector:@selector(initWithDic:) withObject:self.orginDic];
//            [invocation setArgument: &newPageInstance atIndex: 2];//从2开始
//            [invocation invoke];
//            [token1 remove];
//            [token2 remove];
//        } else {
//            [invocation invoke];
//        }
//    }  error:NULL];
//    
//}

- (void)relaceOriginalPage:(NSString *)originalPageClassName withNewPage:(NSString *)newPageClassName newDic:(NSDictionary *)newDic {
    Class originalClass = NSClassFromString(originalPageClassName);
    self.token = [originalClass aspect_hookSelector:@selector(initWithDic:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, NSMutableDictionary *dic) {
        if (newDic) {
            [dic addEntriesFromDictionary:newDic];
        }
        Class newPageClass = NSClassFromString(newPageClassName);
        id newPageInstance = [newPageClass alloc];
        newPageInstance = [newPageInstance performSelector:@selector(initWithDic:) withObject:dic];
        NSInvocation *invocation = [aspectInfo originalInvocation];
        void *newVoidInstance = CFBridgingRetain(newPageInstance);
        [invocation setReturnValue:&newVoidInstance];
    } error:NULL];
}


- (void)relaceOriginalPage:(NSString *)originalPageClassName withNewPage:(NSString *)newPageClassName {
    [self relaceOriginalPage:originalPageClassName withNewPage:newPageClassName newDic:nil];
}

- (void)remove {
    [self.token remove];
}

@end
