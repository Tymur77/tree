//
//  Tree.m
//  Tree
//
//  Created by Виктория on 04.07.2022.
//

#import "Tree.h"


#define min(a, b) a < b ? a : b


extern BOOL permissions;
extern unsigned long maxFilename;
extern enum FileType filetype;
extern size_t c_colors;
extern unsigned char colors[];
extern enum ColorRule colorRule;
extern BOOL debug;
extern BOOL size;


@interface Tree ()

+ (instancetype)tree;
@property NSFileManager *fm;

- (void)printContentsOfDirectory:(NSURL *)directory indent:(const char *)indent level:(size_t)level;
- (void)writePermissionsOfURL:(NSURL *)url toBuffer:(char *)buffer;
- (void)writeSizeOfURL:(NSURL *)url toBuffer:(char *)buffer;

@end


@implementation Tree

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fm = [NSFileManager defaultManager];
    }
    return self;
}

+ (instancetype)tree {
    
    static Tree *tree;
    if (!tree) {
        tree = [[Tree alloc] init];
    }
    return tree;
}

+ (void)printContentsOfDirectory:(NSURL *)directory {
    printf(".\n");
    [self.tree printContentsOfDirectory:directory indent:"" level:0];
}

- (void)writePermissionsOfURL:(NSURL *)url toBuffer:(char *)buffer {
    struct stat s;
    stat(url.path.UTF8String, &s);
    memset(buffer, '-', 11);
    buffer[3] = ' ';
    buffer[7] = ' ';
    
    if ((s.st_mode & S_IRUSR) > 0) buffer[0] = 'r';
    if ((s.st_mode & S_IWUSR) > 0) buffer[1] = 'w';
    if ((s.st_mode & S_IXUSR) > 0) buffer[2] = 'x';
    if ((s.st_mode & S_ISUID) > 0) buffer[2] = 's';
    
    if ((s.st_mode & S_IRGRP) > 0) buffer[4] = 'r';
    if ((s.st_mode & S_IWGRP) > 0) buffer[5] = 'w';
    if ((s.st_mode & S_IXGRP) > 0) buffer[6] = 'x';
    if ((s.st_mode & S_ISGID) > 0) buffer[6] = 's';
    
    if ((s.st_mode & S_IROTH) > 0) buffer[8] = 'r';
    if ((s.st_mode & S_IWOTH) > 0) buffer[9] = 'w';
    if ((s.st_mode & S_IXOTH) > 0) buffer[10] = 'x';
    if ((s.st_mode & S_ISVTX) > 0) buffer[10] = 't';
}

- (void)writeSizeOfURL:(NSURL *)url toBuffer:(char *)buffer {
    struct Size size = MAKE_SIZE(url.size);
    if (size.terabytes > 0) {
        if (sprintf(buffer, "%dTB", size.terabytes) == -1) {
            if (debug) dprintf(STDERR_FILENO, "FILE %s: LINENO %d: sprintf FAIL\n", __FILE_NAME__, __LINE__);
            exit(1);
        }
    } else if (size.gigabytes > 0) {
        if (sprintf(buffer, "%dGB", size.gigabytes) == -1) {
            if (debug) dprintf(STDERR_FILENO, "FILE %s: LINENO %d: sprintf FAIL\n", __FILE_NAME__, __LINE__);
            exit(1);
        }
    } else if (size.megabytes > 0) {
        if (sprintf(buffer, "%dMB", size.megabytes) == -1) {
            if (debug) dprintf(STDERR_FILENO, "FILE %s: LINENO %d: sprintf FAIL\n", __FILE_NAME__, __LINE__);
            exit(1);
        }
    } else if (size.kilobytes > 0) {
        if (sprintf(buffer, "%dKB", size.kilobytes) == -1) {
            if (debug) dprintf(STDERR_FILENO, "FILE %s: LINENO %d: sprintf FAIL\n", __FILE_NAME__, __LINE__);
            exit(1);
        }
    } else {
        if (sprintf(buffer, "%dB", size.bytes) == -1) {
            if (debug) dprintf(STDERR_FILENO, "FILE %s: LINENO %d: sprintf FAIL\n", __FILE_NAME__, __LINE__);
            exit(1);
        }
    }
}

- (void)printContentsOfDirectory:(NSURL *)directory indent:(const char *)indent level:(size_t)level {
    NSArray *contents = [self.fm contentsOfDirectoryAtURL:directory includingPropertiesForKeys:@[NSURLIsDirectoryKey, NSURLTypeIdentifierKey, NSURLFileSizeKey] options:0 error:nil];
    if (contents) {
        char color[12] = "\033[0m";
        if (c_colors) {
            switch (colorRule) {
                case RepeatAll:
                    if (sprintf(color, "\033[38;5;%dm", colors[level % c_colors]) == -1) return;
                    break;
                case RepeatLast:
                    if (sprintf(color, "\033[38;5;%dm", colors[min(level, c_colors - 1)]) == -1) return;
                    break;
                default:
                    return;
            }
        }
        size_t length = strlen(indent);
        // length + 11 + 3 + 3 + 1
        char newIndent[length + 18];
        if (sprintf(newIndent, "%s%s│   ", indent, color) == -1) return;
        for (size_t i = 0; i < contents.count; ++i) {
            if (i == contents.count - 1) {
                if (sprintf(newIndent, "%s%s    ", indent, color) == -1) return;
                printf("%s%s└── \033[0m", indent, color);
            } else {
                printf("%s%s├── \033[0m", indent, color);
            }
            NSURL *url = contents[i];
            BOOL isDirectory = url.isDirectory;
            if (permissions && (size && !isDirectory)) {
                char perm[12] = {0};
                [self writePermissionsOfURL:url toBuffer:perm];
                char size_buffer[7] = {0};
                [self writeSizeOfURL:url toBuffer:size_buffer];
                printf("[%s %s] ", perm, size_buffer);
            } else if (permissions) {
                char perm[12] = {0};
                [self writePermissionsOfURL:url toBuffer:perm];
                printf("[%s] ", perm);
            } else if (size && !isDirectory) {
                char size_buffer[7] = {0};
                [self writeSizeOfURL:url toBuffer:size_buffer];
                printf("[%s] ", size_buffer);
            }
            NSString *filename = url.lastPathComponent;
            if (filename) {
                if (filename.length > maxFilename) {
                    NSString *truncatedFilename = [filename substringToIndex:maxFilename];
                    printf("%s... ", truncatedFilename.UTF8String);
                } else {
                    printf("%s ", filename.UTF8String);
                }
            }
            NSString *type;
            if (filetype && (type = url.type)) {
                printf("(%s) ", type.UTF8String);
            }
            printf("\n");
            if (isDirectory) {
                [self printContentsOfDirectory:url indent:newIndent level:level + 1];
            }
        }
    }
}

@end
