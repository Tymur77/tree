//
//  Tree.h
//  Tree
//
//  Created by Виктория on 04.07.2022.
//

#import <Foundation/Foundation.h>
#import <sys/stat.h>
#import "FileType.h"
#import "NSURL+Extensions.h"
#import "Size.h"
#import "ColorRule.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tree : NSObject

+ (void)printContentsOfDirectory:(NSURL *)directory;
+ (instancetype)alloc NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
