//
//  help.h
//  Tree
//
//  Created by Виктория on 15.08.2022.
//

#ifndef help_h
#define help_h

#define HELP "tree options:\n" \
"-p             Prints the permissions of each entry\n" \
"--permissions  The same as the -p option\n" \
"-t <length>    Limits the length (in UTF-16 units) of filenames. Filenames longer than the specified value will be truncated\n" \
"-e             Prints the filetype of each entry in the form of extension. E.g. png\n" \
"-u             Prints the filetype of each entry in the form of UTI (Uniform Type Identifier). E.g. public.png\n" \
"-c             Applies a different branch color on each level. You can specify up to 10 colors (values in the range 0-255) one by one separated by semicolon (\";\") in TREE_COLORS. If the number of levels is greater than the number of colors, the value of the environment variable must end with an equal sign (\"=\") to repeat only the last color, otherwise the whole sequence of colors will be repeated\n" \
"-s             Prints the size of each entry\n" \
"--size         The same as the -s option\n" \
"-d             Debug. Prints the list of command line arguments before going down the directory\n"

#endif /* help_h */
