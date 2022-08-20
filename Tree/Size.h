//
//  Size.h
//  Tree
//
//  Created by Виктория on 14.08.2022.
//

#ifndef Size_h
#define Size_h

#define MAKE_SIZE(bytes) (struct Size){ \
bytes & 0b1111111111, \
bytes >> 10 & 0b1111111111, \
bytes >> 20 & 0b1111111111, \
bytes >> 30 & 0b1111111111, \
bytes >> 40 & 0b1111111111}

struct Size {
    unsigned short bytes;
    unsigned short kilobytes;
    unsigned short megabytes;
    unsigned short gigabytes;
    unsigned short terabytes;
};

#endif /* Size_h */
