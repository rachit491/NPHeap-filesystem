# NPHeap-filesystem

Overview

In the previous project, we have built NPHeap, an in-memory kernel module that provides efficient data sharing among different processes. Although NPHeap provides the ability to share data among processes, NPHeap still requires programmers to change legacy applications to take advantages from NPHeap. As modifying code is error-prone and time-consuming, this results in difficulties in adopting NPHeap, especially for applications that are already using files to share data. 

In this project, you will be building a file system on top of an NPHeap device. The file system must be compatible with conventional file system operations that existing applications can easily access it without modifying any line of code. On the other hand, applications supporting NPHeap can still use mmap to access data in the NPHeap device.

This project relies on NPHeap pseudo device that you implemented in the previous project as the data storage. Instead of implementing a file system from scratch, you will be using libfuse 2.9. Fuse is a library that hides most low-level details of file systems and allows programmers to design a file system running in the user-space. With the kernel module and the library of fuse take care of all low-level system interactions, you simply need to focus on those data structures and operations that maintain the abstraction of a file system on NPHeap.

You are strongly encouraged to work in a group of 2 or 3. Groups do the same project as individuals. All members will receive the same grade. Note that working in groups may or may not make the project easier, depending on how the group interactions work out. If collaboration issues arise, contact your instructor as soon as possible: flexibility in dealing with such issues decreases as the deadline approaches. 

In this project, you will be given the prototype of the NPHFS file system. the  src/nphfuse.c file contains the some basic functions that are mainly for initialization as well as the declaration of supported operations. The src/nphfuse_function.c that only contains empty functions -- you need to implement those to make the file system work. You may also define your own file system status structures and other important file system structures in the src/nphfuse_extra.h header file.

Objective

* Learning essential operations of a file system
* Learning how system library interact with file systems
* Designing a file system for innovative storage devices

How to start 

To begin, you need to first form a group and setup the environment for developing your project. You should set up a machine or a VMWare virtual machine (CS students should have free license for that https://www.csc.ncsu.edu/vmap/) with clean Ubuntu 16.04 installation. You also may use the VCL service maintained by NCSU through https://vcl.ncsu.edu/ . You may reserve one virtual machine and connect to this machine remotely by selecting reservations. We will use the "Ubuntu 16.04 Base" to test your kernel module. However, the VCL service will reset once your reservation timeouts. The default image in VCL service already has libfuse-2.9 installed. In you don't have one in your environment, please make sure that you get one through "sudo apt-get install libfuse-dev" command.

You also need to install those header files from NPHeap by using files from https://github.ncsu.edu/htseng3/CSC501_NPHeap.git. You will need a working NPHeap kernel module from project #1. If you don't have a properly working version, you may download and use the npheap kernel module from https://github.ncsu.edu/htseng3/CSC501_TNPHEAP/tree/master/NPHeap. 

Finally, you may fetch the code from https://github.ncsu.edu/htseng3/CSC501_NPHFS. After fetching the code, you can type

./configure

In the fetched repo. 

If the configure works successfully, you may type 

make 

to compile the code. Upon success, you should find an "nphfuse" executable in the src directory. To test the nphfuse file system, you will have to first insert the npheap kernel module by performing "sudo insmod npheap.ko" and "sudo chmod 777 /dev/npheap" as in previous projects. After you have done these, you can launch the file system by using

nphfuse /dev/npheap {mount_point}

where {mount_point} is an empty directory serve as the mount point. We strongly recommend you to add "-s -d" arguments when you launch the nphfuse program since this will show you more debugging information.

At this point, your file system won't work at all. You may not see anything when you do "ls". You will see errors when you create files. You will see error messages when you try to do "df" that shows the free space on each partition. -- Yes, it's your job to make all of these plus some other features that make this file system working.

After you have some initial understanding about this project, we strongly encourage you to review the overview, those references, and then discuss with your teammate(s). You and your team should obtain a high-level system architecture before you start writing any idea. You should discuss with TAs and the instructor during their office hours as early as possible. 

No matter you're using VMWare, real machine, or VCL, you should always use https://github.ncsu.edu to control/maintain/backup your work.

Your tasks

1. You are responsible for completing at least the following functions in the given fuse_functions.c to support the required features that make the file system work on npheap. You may use existing system calls and npheap library functions to accomplish your task if appropriate. You may design any data structure that supports the required features. Here is the list of functions you need to accomplish at least:


1. int nphfuse_getattr(const char *path, struct stat *statbuf);
2. int nphfuse_readlink(const char *path, char *link, size_t size);
3. int nphfuse_mknod(const char *path, mode_t mode, dev_t dev);
4. int nphfuse_mkdir(const char *path, mode_t mode);
5. int nphfuse_unlink(const char *path);
6. int nphfuse_rmdir(const char *path);
7. int nphfuse_symlink(const char *path, const char *link);
8. int nphfuse_rename(const char *path, const char *newpath);
9. int nphfuse_link(const char *path, const char *newpath);
10. int nphfuse_chmod(const char *path, mode_t mode);
11. int nphfuse_chown(const char *path, uid_t uid, gid_t gid);
12. int nphfuse_truncate(const char *path, off_t newsize);
13. int nphfuse_utime(const char *path, struct utimbuf *ubuf);
14. int nphfuse_open(const char *path, struct fuse_file_info *fi);
15. int nphfuse_read(const char *path, char *buf, size_t size, off_t offset, struct fuse_file_info *fi);
16. int nphfuse_write(const char *path, const char *buf, size_t size, off_t offset, struct fuse_file_info *fi);
17. int nphfuse_statfs(const char *path, struct statvfs *statv);
18. int nphfuse_release(const char *path, struct fuse_file_info *fi);
19. int nphfuse_opendir(const char *path, struct fuse_file_info *fi);
20. int nphfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler, off_t offset, struct fuse_file_info *fi);
21. int nphfuse_releasedir(const char *path, struct fuse_file_info *fi);
22. int nphfuse_fsyncdir(const char *path, int datasync, struct fuse_file_info *fi);
23. void *nphfuse_init(struct fuse_conn_info *conn);
24. void nphfuse_destroy(void *userdata);
25. int nphfuse_access(const char *path, int mask);
26. int nphfuse_ftruncate(const char *path, off_t offset, struct fuse_file_info *fi);
27. int nphfuse_fgetattr(const char *path, struct stat *statbuf, struct fuse_file_info *fi);

2. Test the developed program: It's your responsibility to test the developed file system. Your program should pass the following criteria:
* create directories -- e.g. can you mkdir some_directory_name and then cd into it? 
* store thousands of files -- you may start with using "wget" to crawl website contents. (e.g. type "wget -r  https://systems.csc.ncsu.edu/" within the mount point of NPHFS)
* "ls -al" can see the files correctly -- can you use ls to see all the file/directory names, their permissions, their dates, their sizes correctly?
* "df" can see the capacity (say initially your drive can store 16384 files * 8K each. -- can you show how many space this mounted partition still has?
* touch can update the modification time -- touch a file within the mount point and "ls -al" that file again to see if you successfully update the modification date.
* remove directories -- rmdir or rm -rf of some directory.
* rename files/directories -- mv original_filename new_filename
* chmod any file / directory
* chown any file / directory
* diff the file content is consistent with the original content from another directory -- cp -r original_directory new_directory -- original one from a non-NPHFS device and the new one lives on NPHFS.
* make sure users without permission cannot access the content
* We will unmount the file system and remount to test if everything works still.
Turn ins

You only need to (or say you can only) turn in the nphfuse_functions.c and nphfuse_extra.h file in the src directory. All your modifications should be limited within these two files. Exactly 1 member of each group should submit the source code.

All group members' names and Unity IDs should be easily found in a single line comment at the beginning of the code in the following format:

// Project 3: 1st member's name, 1st member's Unity ID; 2nd member's name, 2nd member's Unity ID; 3rd member's name, 3rd  member's Unity ID; 

You need to name the tarball as {1st_members_unityid}_{2nd_members_unityid}_{3rd_members_unityid}_nphfs.tar.gz

Reference and hints

1. You should go through the example and docs in libfuse-2.9 github repo https://github.com/libfuse/libfuse/tree/fuse-2_9_bugfix

2. You may reference this tutorial https://www.cs.nmsu.edu/~pfeiffer/fuse-tutorial/ to see how fuse interact with the system. However, we have real device -- npheap, you cannot really use the way how they implement the file system.

3. Here is another good reference regarding fuse https://engineering.facile.it/blog/eng/write-filesystem-fuse/

4. You will find out that chapter 39 and chapter 40 of the textbook are really useful.
