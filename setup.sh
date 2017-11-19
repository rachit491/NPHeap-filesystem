fusermount -u ~/mnt
sudo rm -rf ~/mnt
sudo rmmod npheap.ko

./configure
make
sudo make install

cd src
sudo insmod npheap.ko
sudo chmod 777 /dev/npheap

sudo mkdir ~/mnt
sudo nphfuse /dev/npheap ~/mnt