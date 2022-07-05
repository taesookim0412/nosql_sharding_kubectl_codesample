# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html

lsblk
# we see nvme1n1
sudo file -s /dev/nvme1n1
# /dev/nvme1n1 : data

# format the drive ( only if it is not formatted yet!! )
sudo mkfs -t xfs /dev/nvme1n1

sudo mkdir /mnt/sdf

sudo mount /dev/nvme1n1 /mnt/sdf

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html#ebs-mount-after-reboot

sudo lsblk

sudo lsblk -o +UUID

sudo cp /etc/fstab /etc/fstab.orig

sudo nano /etc/fstab

UUID=aebf131c-6957-451e-8d34-ec978d9581ae  /mnt/sdf  xfs  defaults,nofail  0  2

#our new drive is 4e92e437-28d1-4462-93bd-7709e10db167
UUID=4e92e437-28d1-4462-93bd-7709e10db167  /mnt/sdf  xfs  defaults,nofail  0  2

sudo umount /mnt/sdf
sudo mount -a
