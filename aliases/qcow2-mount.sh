### Commands to mount and unmount a qcow2 image, for modifications
## $1 is the qcow2 image
## $2 is optional, mountpoint, which defaults to /mnt
# TODO: check if qemu-nbd is installed
# TODO: if current working directory is inside the mountpoint, then
#   move out of that directory and then umount

mntq () {
    if [[ -z $1 ]]; then
        echo "  usage: mntq image-to-mount.qcow2 [/mountpoint]"
        kill -INT $$
    fi
    MNTPOINT=/mnt
    if [[ ! -z $2 ]]; then
        $MNTPOINT=$2;
    fi
    sudo modprobe nbd;
    sudo qemu-nbd -c /dev/nbd0 $1
    sudo mount /dev/nbd0p1 $MNTPOINT
}

umntq () {
    MNTPOINT=/mnt
    if [[ ! -z $1 ]]; then
        $MNTPOINT=$1;
    fi
    sudo umount $MNTPOINT
    sudo qemu-nbd -d /dev/nbd0
}

