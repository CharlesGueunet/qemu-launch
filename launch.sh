#!/bin/bash -
#===============================================================================
#
#          FILE: launch.sh
#
#         USAGE: ./launch.sh
#
#   DESCRIPTION: Launch a vm with qemu
#
#       OPTIONS: qemu additional options
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Charles Gueunet
#  ORGANIZATION: EISTI
#       CREATED: 04/23/2015 11:07
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -e                                      # Exit at first error (non-zero terminated cmd)

function print_usage() {
    echo $0 "[OPTION]"
    echo
    echo "OPTION"
    echo " -n NAME : name of the VM"
    echo " -p PORT : port where the VM will be launched [the user need to have required rights]"
    echo " -g : this option activate graphical output"
    echo " -h : this help"
    exit
}

# This VM
vm_hostame="Debian"
vm_name="Debian"
vm_port=22000

# Files
cd_rom="debian.iso"
drive="debian.qcow2"

# command line
graphic="-nographic"
while getopts "n:p:g:h" OPTION
do
    case $OPTION in
        n)
            vm_name=$OPTARG
            ;;
        p)
            vm_port=$OPTARG
            ;;
        g)
            graphic=""
            ;;
        h)
            print_usage
            ;;
    esac
done

# Start
# To boot the CD : boot d on start
# for shared data : add argument
# -virtfs local,path="hostPath0",mount_tag=host0,security_model=mapped-xattr,id=host0 \
# -virtfs local,path="hostPath1",mount_tag=host1,security_model=mapped-xattr,id=host1 \
# ...
# Each of these need to be mapped in the guest fstab :
# host0   /wherever0    9p      trans=virtio,version=9p2000.L   0 0
# host1   /wherever1    9p      trans=virtio,version=9p2000.L   0 0
# ...
# -> Note, when using the virtfs line inside a variable :
# qemu-system-x86_64: -virtfs local[...]: 9pfs Failed to initialize fs-driver with id:host0 and export path:"..."


echo " VM : $vm_name start ..."
echo " connect on $vm_port "

exec qemu-system-x86_64 -enable-kvm \
    -name $vm_name  \
    -boot c \
    -cdrom $cd_rom \
    -hda $drive \
    -net nic,vlan=0  \
    -net user,vlan=0,hostname="$vm_hostame",hostfwd=tcp::${vm_port}-:22 \
    -localtime \
    -m 6G \
    -cpu host -smp 4 \
    $graphic \
    &
