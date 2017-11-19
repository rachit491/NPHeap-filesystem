/*
  Copyright (C) 2016 Hung-Wei Tseng, Ph.D. <hungwei_tseng@ncsu.edu>

  This program can be distributed under the terms of the GNU GPLv3.
  See the file COPYING.

  You may extend this file if necessary  
*/

#include <time.h>
#include <sys/types.h>
#include <stdbool.h>
#include <sys/stat.h>

struct nphfuse_state {
    FILE *logfile;
    char *device_name;
    int devfd;
};

struct file_struct {
    __u64 offset;
    char *file_name;
    char *file_path;
    struct stat *dir_struct;
    bool is_directory;
    struct file_struct *parent;
    struct file_struct *next;
}*root;
