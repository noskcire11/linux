## Disk preparation
### Partition the Disk with LVM
Use the `fdisk` command to create your disk partitions. For LVM, change the type partition to `lvm`.
```
root@archiso ~ # fdisk /dev/<disk>
Command (m for help): t
Partition number (1-n, default n): <lvm-partition-number>
Partition type or alias (type L to list all): lvm
```

### Format the EFI partition
```
root@archiso ~ # mkfs.fat -F 32 -n ARCH_EFI /dev/<efi-partition>
```

### LVM!
```
root@archiso ~ # pvcreate /dev/<lvm-partition>
root@archiso ~ # vgcreate archvg /dev/<lvm-partition>
root@archiso ~ # lvcreate -L <size> -n root archvg
root@archiso ~ # mkfs.ext4 -L ARCH /dev/archvg/root
```

## Install the Archlinux

### Connect Wi-Fi
```
root@archiso ~ # iwctl device list
root@archiso ~ # iwctl station <device> scan
root@archiso ~ # iwctl station <device> get-networks
root@archiso ~ # iwctl station <device> connect <ssid>
```

### Installation
```
root@archiso ~ # mount /dev/archvg/root /mnt
root@archiso ~ # mount --mkdir /dev/<efi-partition> /mnt/boot
root@archiso ~ # pacstrap -K /mnt \
                 base linux linux-lts linux-zen linux-firmware\
                 intel-ucode efibootmgr sudo lvm2 networkmanager \
                 networkmanager gvim man-db man-pages texinfo
```

### Fstab
```
root@archiso ~ # genfstab -L /mnt >> /mnt/etc/fstab
```

### Chroot
```
root@archiso ~ # arch-chroot /mnt
[root@archiso /]# 
```

### Time zone
```
[root@archiso /]# ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
[root@archiso /]# hwclock --systohc
```

### Localization
Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8.
```
[root@archiso /]# vim /etc/locale.gen
[root@archiso /]# locale-gen
```
Create the locale.conf(5) file, and set the LANG variable accordingly:
```
/etc/locale.conf
----------------
LANG=en_US.UTF-8
```

### Network configuration
Create the hostname file:
```
/etc/hostname
-------------
arch
```
Create hosts file:
```
/etc/hosts
-----------------------------
127.0.0.1        localhost
::1              localhost
127.0.1.1        arch
```
Enable networkmanager
```
[root@archiso /]# systemctl enable NetworkManager
```

### Initramfs for LVM
In case your root filesystem is on LVM, you will need to enable the appropriate mkinitcpio hooks, otherwise your system might not boot. Edit the file and insert `lvm2` between `block` and `filesystems`.
```
/etc/mkinitcpio.conf
--------------------------------------------
HOOKS=(base udev ... block lvm2 filesystems ...)
```
Recreate the initramfs image.
```
[root@archiso /]# mkinitcpio -P
```

### Visudo
```
/etc/sudoers
------------------------
%wheel ALL=(ALL:ALL) ALL
```

### Add user
```
[root@archiso /]# useradd -m -G wheel erickson
[root@archiso /]# passwd erickson
```

### Bootloader
```
[root@archiso /]# efibootmgr \
                  --create \
                  --disk /dev/<disk> \
                  --part <efi-part-num> \
                  --label "arch (linux)" \
                  --loader /vmlinuz-linux \
                  --unicode 'root="LABEL=ARCH" rw initrd=\intel-ucode.img initrd=\initramfs-linux.img'

[root@archiso /]# efibootmgr \
                  --create \
                  --disk /dev/<disk> \
                  --part <efi-part-num> \
                  --label "arch (linux-lts)" \
                  --loader /vmlinuz-linux-lts \
                  --unicode 'root="LABEL=ARCH" rw initrd=\intel-ucode.img initrd=\initramfs-linux-lts.img'

[root@archiso /]# efibootmgr \
                  --create \
                  --disk /dev/<disk> \
                  --part <efi-part-num> \
                  --label "arch (linux-zen)" \
                  --loader /vmlinuz-linux-zen \
                  --unicode 'root="LABEL=ARCH" rw initrd=\intel-ucode.img initrd=\initramfs-linux-zen.img'
```

### Reboot
```
[root@archiso /]# exit
root@archiso ~ # umount -R /mnt
reboot
```

## Post-installation
### Connect Wi-Fi
```bash
[erickson@arch ~]$ nmcli device wifi list
[erickson@arch ~]$ nmcli device wifi connect <ssid> password <password>
```