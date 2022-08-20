//
//  NSURL+Extensions.m
//  Tree
//
//  Created by Виктория on 14.08.2022.
//

#import "NSURL+Extensions.h"


extern enum FileType filetype;


@implementation NSURL (Extensions)

- (BOOL)isDirectory {
    NSNumber *directory = @0;
    [self getResourceValue:&directory forKey:NSURLIsDirectoryKey error:nil];
    return directory.boolValue;
}
- (NSString *)type {
    NSString *uti = @"public.item";
    NSString *ext;
    [self getResourceValue:&uti forKey:NSURLTypeIdentifierKey error:nil];
    switch (filetype) {
        case EXTENSION:
            ext = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)uti, kUTTagClassFilenameExtension);
            return ext;
        case UTI:
            return uti;
        default:
            return nil;
    }
}
- (unsigned long long)size {
    NSNumber *size = @0;
    [self getResourceValue:&size forKey:NSURLFileSizeKey error:nil];
    return size.unsignedIntegerValue;
}

@end
