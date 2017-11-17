./configure
make
cd src
sudo insmod npheap.ko
sudo chmod 777 /dev/npheap

cd ..
mkdir ~/mnt
nphfuse /dev/npheap ~/mnt -s -d

ls
df