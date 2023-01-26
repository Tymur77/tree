# tree
tree is a command line application for MacOS written in Objective-C that allows to list full contents of working directories in a way that reminds of a tree.
![screen shot](https://github.com/Tymur77/tree/blob/master/Images/screen_shot.png)

You can [download](https://github.com/Tymur77/tree/blob/master/Build/Products/Debug/Tree?raw=true) the binary or install the binary with [the 
installer](https://github.com/Tymur77/tree/blob/master/Build/Products/Install%20Tree.pkg?raw=true) instead of compiling the code.

Font in the screenshot: MesloLGS NF. [Download](https://github.com/Tymur77/tree/blob/master/MesloLGS%20NF%20Regular.ttf?raw=true).

## Help information
Specify -h in the terminal to get help.

| Option | Description |
| ------ | ------ |
| -p | Prints the permissions of each entry |
| -t <length> | Limits the length (in UTF-16 units) of filenames. Filenames longer than the specified value will be truncated |
| -e | Prints the filetype of each entry in the form of extension. E.g. png |
| -u | Prints the filetype of each entry in the form of UTI (Uniform Type Identifier). E.g. public.png |
| -c | Applies a different branch color on each level. You can specify up to 10 colors (values in the range 0-255) one by one separated by semicolon (";") in TREE_COLORS. If the number of levels is greater than the number of colors, the value of the environment variable must end with an equal sign ("=") to repeat only the last color, otherwise the whole sequence of colors will be repeated |
| -s | Prints the size of each entry |
| -d | Debug. Prints the list of command line arguments before going down the directory |
