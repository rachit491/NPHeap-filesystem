./configure
make
cd src
sudo insmod npheap.ko
sudo chmod 777 /dev/npheap

cd
mkdir mount
nphfuse /dev/npheap mount -s -d

ls
df