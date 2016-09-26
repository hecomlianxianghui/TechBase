//
//  PageReplace.m
//  FrameworkDemo
//
//  Created by lianxianghui on 16/9/24.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "PageReplace.h"
#import "PageNavigationInterceptor.h"

@interface PageReplace ()
@property (nonatomic) NSMutableDictionary<NSString *, PageNavigationInterceptor *> *interceptorDic;
@end

@implementation PageReplace

- (id)init {
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"page_replace" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *replaceItems = data[@"replaceItems"];
        [replaceItems enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addPageReplaceWithOrignalClassName:dic[@"origin"] newPageClassName:dic[@"new"]];
        }];
    }
    return self;
}

- (void)addPageReplaceWithOrignalClassName:(NSString *)originalClassName newPageClassName:(NSString *)newPageClassName {
    [self removeWithOrignalClassName:originalClassName];
    PageNavigationInterceptor *interceptor = [PageNavigationInterceptor new];
    [interceptor relaceOriginalPage:originalClassName withNewPage:newPageClassName];
    self.interceptorDic[originalClassName] = interceptor;
}

- (void)removeWithOrignalClassName:(NSString *)originalClassName {
    if (self.interceptorDic[originalClassName]) {
        [self.interceptorDic[originalClassName] remove];
        self.interceptorDic[originalClassName] = nil;
    }
}

- (void)removeAll {
    
}

- (NSMutableDictionary *)interceptorDic {
    if (!_interceptorDic) {
        _interceptorDic = [NSMutableDictionary new];
    }
    return _interceptorDic;
}

@end
