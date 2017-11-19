/*
  Copyright (C) 2016 Hung-Wei Tseng, Ph.D. <hungwei_tseng@ncsu.edu>

  This program can be distributed under the terms of the GNU GPLv3.
  See the file COPYING.

  You may extend this file if necessary  
*/

#include <time.h>
#include <stdbool.h>

struct nphfuse_state {
    FILE *logfile;
    char *device_name;
    int devfd;
    char *rootdir;
};

struct file_struct {
	char *file_name;
	struct stat new_dir;
	bool is_directory;
};
