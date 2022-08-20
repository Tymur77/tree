//
//  help.h
//  Tree
//
//  Created by Виктория on 15.08.2022.
//

#ifndef help_h
#define help_h

#define HELP "tree options:\n" \
"-p             Print permissions of each file or directory.\n" \
"--permissions  The same as the -p option.\n" \
"-t <length>    The maximum length for filenames. Files with the name length exceeding the value will be truncated.\n" \
"-e             Print filetype of each file or directory in the form of extension (e.g. png).\n" \
"-u             Print filetype of each file or directory in the form of uti (e.g. public.png).\n" \
"-c             Colorful option. To control the order of colors, set the TREE_COLORS environment variable accordingly. An example might be \"74;84\". Here 74 and 84 are one of the 256 colors. The maximum number of colors is 10. If the value ends with an equal sign (\"=\"), the last color will be repeated as many times as needed, otherwise the whole sequence will be repeated.\n" \
"-s             Print size of each file or directory.\n" \
"--size         The same as the -s option.\n" \
"-d             Debug. Prints the list of command line arguments before going down the directory.\n"

#endif /* help_h */
