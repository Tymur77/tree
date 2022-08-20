//
//  NSURL+Extensions.h
//  Tree
//
//  Created by Виктория on 14.08.2022.
//

#import <Foundation/Foundation.h>
#import "FileType.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Extensions)

@property(readonly, getter=isDirectory) BOOL directory;
@property(readonly) NSString *type;
@property(readonly) unsigned long long size;

@end

NS_ASSUME_NONNULL_END
