# tree
tree is a command line application for MacOS written in Objective-C, that allows to list full contents of working directories in a way that reminds of a tree.
![screen shot](https://github.com/Tymur77/tree/blob/master/Images/screen_shot.png)
## Options
| Name |      Full name     | Description |
|--|--|--|
| -d |  | Debug. Prints the list of command line arguments before going down the directory. |
| -p | -\-permissions | Print permissions of each file or directory. |
| -s | -\-size | Print size of each file or directory. |
| -t \<length> |  | The maximum length for filenames. Files with the name length exceeding the value will be truncated. |
| -e |  | Print filetype of each file or directory in the form of extension (e.g. png). |
| -u |  | Print filetype of each file or directory in the form of uti (e.g. public.png). |
| -c |  | Colorful option. To control the order of colors, set the TREE_COLORS environment variable accordingly. An example might be "74;84". Here 74 and 84 are one of the 256 colors. The maximum number of colors is 10. If the value ends with an equal sign ("="), the last color will be repeated as many times as needed, otherwise the whole sequence will be repeated. |
