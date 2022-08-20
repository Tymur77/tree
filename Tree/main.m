//
//  main.m
//  Tree
//
//  Created by Виктория on 03.07.2022.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
#import <unistd.h>
#import <string.h>
#import "FileType.h"
#import "help.h"
#import "ColorRule.h"


#define TRUE_FALSE "<Истина>" : "<Ложь>"
#define MAX_COLORS 10


BOOL permissions = NO;
unsigned long maxFilename = ULONG_MAX;
enum FileType filetype = 0;
size_t c_colors = 0;
unsigned char colors[MAX_COLORS + 1] = {0};
enum ColorRule colorRule = 0;
BOOL debug = NO;
BOOL size = NO;


int parseColors(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char opt, *endptr;
        long t;
        static dispatch_once_t pred;
        opterr = 0;
        
        while ((opt = getopt(argc, argv, "p-:t:eucsdh")) != -1) {
            switch (opt) {
                case 'p':
                    permissions = YES;
                    break;
                case '-':
                    if (strcmp(optarg, "permissions") == 0) {
                        permissions = YES;
                        break;
                    } else if (strcmp(optarg, "size") == 0) {
                        size = YES;
                        break;
                    } else if (strcmp(optarg, "help") == 0) {
                        printf(HELP);
                        return 0;
                    } else {
                        dprintf(STDERR_FILENO, "Unknown option: '--%s'\n", optarg);
                        return 1;
                    }
                case 't':
                    if (
                        isspace(optarg[0]) ||
                        (t = strtol(optarg, &endptr, 10)) <= 0 ||
                        errno == ERANGE ||
                        endptr < optarg + strlen(optarg))
                    {
                        dprintf(STDERR_FILENO, "Argument for option -t must be a positive integer\n");
                        return 1;
                    }
                    else
                    {
                        maxFilename = t;
                        break;
                    }
                case 'e':
                    if (filetype == UTI) {
                        dprintf(STDERR_FILENO, "-e and -u options can't both be specified\n");
                        return 1;
                    } else {
                        filetype = EXTENSION;
                        break;
                    }
                case 'u':
                    if (filetype == EXTENSION) {
                        dprintf(STDERR_FILENO, "-e and -u options can't both be specified\n");
                        return 1;
                    } else {
                        filetype = UTI;
                        break;
                    }
                case 'c':
                    dispatch_once(&pred, ^{
                        if (parseColors() != 0) {
                            dprintf(STDERR_FILENO, "Environment variable TREE_COLORS has invalid format\n");
                            exit(1);
                        }
                    });
                    break;
                case 's':
                    size = YES;
                    break;
                case 'd':
                    debug = YES;
                    break;
                case 'h':
                    printf(HELP);
                    return 0;
                case '?':
                    if (optopt == 't') {
                        dprintf(STDERR_FILENO, "Option -t requires an argument\n");
                    } else {
                        dprintf(STDERR_FILENO, "Unknown option: -%c\n", optopt);
                    }
                    return 1;
                default:
                    dprintf(STDERR_FILENO, "Error: %d\n", errno);
                    return 1;
            }
        }
        
        if (debug) {
            printf(
                   "DEBUG: FILE %s: LINENO %d: -p = %s, -t = %s (%lu), -e = %s, -u = %s, -c = %s, -s = %s, -d = %s\n",
                   __FILE_NAME__,
                   __LINE__,
                   permissions ? TRUE_FALSE,
                   maxFilename < ULONG_MAX ? TRUE_FALSE,
                   maxFilename,
                   filetype == EXTENSION ? TRUE_FALSE,
                   filetype == UTI ? TRUE_FALSE,
                   c_colors ? TRUE_FALSE,
                   size ? TRUE_FALSE,
                   1 ? TRUE_FALSE);
        }
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *cwd = [[NSURL alloc] initFileURLWithPath: fm.currentDirectoryPath];

        [Tree printContentsOfDirectory:cwd];
    }
    return 0;
}


int parseColors() {
    const char *var = getenv("TREE_COLORS");
    if (!var) return 1;
    
    const char *endptr = var;
    for (size_t i = 0; i < MAX_COLORS; ++i) {
        long c = strtol(endptr, &endptr, 10);
        if (errno == EINVAL || errno == ERANGE || c < 0 || c > 255) return 1;
        colors[c_colors++] = c;
        if (*endptr == ';') {
            ++endptr;
            continue;
        } else if (*endptr == '\0') {
            colorRule = RepeatAll;
            return 0;
        } else if (*endptr == '=') {
            colorRule = RepeatLast;
            return 0;
        } else {
            return 1;
        }
    }
    colorRule = RepeatAll;
    return 0;
}
