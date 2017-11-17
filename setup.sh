sudo rmmod npheap.ko
./configure
make
sudo make install

cd src
sudo insmod npheap.ko
sudo chmod 777 /dev/npheap

mkdir ~/mnt
nphfuse -s -d /dev/npheap ~/mnt

ls
df