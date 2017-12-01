fusermount -u src/mount
rm -rf src/mount src/NPHeapFS.log src/nphfuse
sudo rmmod npheap

./configure
make
sudo make install

#cd src
sudo insmod src/npheap.ko
sudo chmod 777 /dev/npheap

mkdir src/mount
