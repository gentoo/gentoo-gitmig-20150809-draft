#!/bin/sh

export PATH=/usr/lib/portage/bin:${PATH}


eval `import-settings PORTDIR PKGDIR PACKAGE PORTAGE_TMPDIR`
export BROOT=${PORTAGE_TMPDIR}/boot
export BOOTIMG=${BROOT}/bootcd
export INITDISK=${BROOT}/initrd
export PORTDIR=$PORTDIR/gentoo-x86
export BOOTDIR=$PORTDIR/sys-apps/bootdisk
export KERNEL=${PKGDIR}/All/linux-bootdisk-2.4.0_rc10-r7.${PACKAGE}


if [ ! -d "${BOOTDIR}" ]
then
  echo "Sorry no bootdisk in the cvs tree $PORTDIR !"
  exit 1
fi

if [ ! -f "${KERNEL}" ]
then
  echo "Sorry no kernel-package found in ${KERNEL}!"
  exit 1
fi


dodirs() {
  for i in $@
  do
    mkdir $i
  done
}

doexes() {
  for i in $@
  do
    cp `which $i` $i
    strip $i &>/dev/null
  done
}


mkbootimg() {

        echo ">>> Creating boot.img"
        echo

        cd ${BOOTIMG}

        # *********** 1 ************

        echo "1. Creating basic dirs"
        dodirs bin dev initrd lib sbin usr

        # *********** 2 ************

        echo "2. Creating initdisk stuff in initrd first"
        cd ${BOOTIMG}/initrd
        dodirs dev proc distcd etc root tmp var mnt
        cd mnt
        dodirs floppy gentoo ram boot
        ln -sf /initrd/distcd .
        cd ..
        ln -sf mnt/boot boot

        # *********** 3 ************

        echo "3. Creating /initrd devices"
        cd ${BOOTIMG}/initrd/dev
	mknod -m 666 tty c 5 0
        mknod -m 600 tty1 c 4 1
        mknod -m 600 tty2 c 4 2
	mknod -m 400 initrd b 1 250
        mkfifo -m 600 initctl
        mkdir pts

        # *********** 4 ************

        echo "4. Populating /initrd/etc"
        cd ${BOOTIMG}/initrd/etc
        cp -af ${BOOTDIR}/files/etc.boot/* .
        rm -r CVS
        touch ld.so.conf
	mkdir modules
	cp ${BROOT}/kernel/lib/modules/2.4.0-test10/modules.* modules

        # *********** 5 ************

        echo "5. Creating other dirs for initrd"
        cd ${BOOTIMG}/initrd/var
        dodirs log run state
	mkdir state/nfs
        touch log/wtmp
        touch run/utmp

        # *********** 6 ************

        echo "6. Creating links to initrd"
        cd ${BOOTIMG}
        for i in etc root tmp var mnt proc
        do
            ln -s initrd/$i $i
        done



        # *********** 7 ************

        echo "7. Creating devices"
        cd ${BOOTIMG}/dev
        tar xzf ${BOOTDIR}/files/devices.tgz -C .
        ln -s ram0 ram

        # *********** 8 ************

        echo "8. Creating device links to initrd"
	rm tty1 tty2
        ln -s ../initrd/pts pts
#        ln -sf ../initrd/dev/initctl .
#        ln -sf ../initrd/dev/initrd .
        ln -sf ../initrd/dev/tty .
        ln -sf ../initrd/dev/tty1 .
        ln -sf ../initrd/dev/tty2 .


        # *********** 9 ************

        echo "9. Populating /bin"
        cd ${BOOTIMG}/bin
        doexes bash cat chgrp chmod chown cp df du hostname kill ldd ln login \
	         ls mkdir mknod mount mv ping ps rm umount uname
        ln -s bash sh

        # *********** 10 ************

        echo "10. Populating /sbin"
        cd ${BOOTIMG}/sbin
        doexes agetty cfdisk depmod e2fsck fdisk grub halt ifconfig init insmod \
	        ldconfig lilo ln lsmod mke2fs mkraid mkreiserfs mkswap portmap \
	        raidstart reboot resize2fs reiserfsck \
	        route sfdisk shutdown touch

        # portmap? removed; Ups added again
        # reiserfsck and resize_reiserfs does not exist in 2.4 so 
	# you need the 2.2.18 kernel installed too!

	# Copy kernel binaries
	cp -a ${BROOT}/kernel/sbin/* .
	cp /sbin/rpc.statd .
        ln -s insmod modprobe
        ln -s mkraid raid0run
        ln -s raidstart raidhotadd
        ln -s raidstart raidhotremove
        ln -s raidstart raidstop
        cp ${PORTDIR}/autoinstaller.sh .
        cp ${BOOTDIR}/files/sbin/rc . 

        # *********** 11 ************

        echo "11. Creating /usr dirs"
        cd ${BOOTIMG}/usr
        dodirs bin lib sbin share

        # *********** 12 ************

        echo "12. Populating /usr/bin"
        cd ${BOOTIMG}/usr/bin
        doexes awk bzip2 cut expr fdformat ftp grep gzip joe killall \
	        loadkeys most rm rmdir scp sed sleep ssh strace tar top vi wget

        # *********** 13 ************

        echo "13. Populating /usr/sbin"
        cd ${BOOTIMG}/usr/sbin
        cp /usr/sbin/rc-update .

        # *********** 14 ************

        echo "14. Populating /usr/share"
        cd ${BOOTIMG}/usr/share
        echo "   - keymaps"
        cp -af /usr/share/keymaps .
        echo "   - tabset"
        cp -af /usr/share/tabset .
        echo "   - terminfo"
        cp -af /usr/share/terminfo .

        # *********** 15 ************

        echo "15. Populating /usr/lib"
        cd ${BOOTIMG}/usr/lib
        cp /usr/lib/joerc .
        cp /lib/libnss_files.so.2 .
        cp /lib/security/pam_permit.so ${BOOTIMG}/lib/pam_permit.so

        # *********** 16 ************

        echo "16. Finding required libs"
        for j in "/bin" "/sbin" "/usr/bin" "/usr/sbin"
        do
            echo "   - $j"
            myfiles=`find ${BOOTIMG}$j -print | /usr/lib/portage/bin/find-requires | grep -v "/bin/bash" | grep -v "/bin/sh"`

            for i in $myfiles
            do
                if [ -f /lib/$i ]
                then
                    cp /lib/$i ${BOOTIMG}/lib/$i
                    strip ${BOOTIMG}/lib/$i
                else
                    if [ -f /usr/lib/$i ]
                    then
                        cp /usr/lib/$i ${BOOTIMG}/usr/lib/$i
                        strip ${BOOTIMG}/usr/lib/$i &>/dev/null
                    else
                        echo "!!! $i not found !"
                    fi
                fi
            done
        done
        ldconfig -r ${BOOTIMG} -f /initrd/etc/ld.so.conf

        # *********** 17 ************

	echo "17. Copying kernel modules"
	cd ${BOOTIMG}/lib
	cp -a ${BROOT}/kernel/lib/modules .
	cd modules/2.4.0-test10
	rm modules.*
	ln -s ../../../initrd/etc/modules/modules.* .

	# *********** 18 ************
        echo
        echo "18. boot.img successfully created in ${BOOTIMG}"
	echo
}

mkinitrd() {

        echo ">>> Creating initdisk"
        echo

        cd ${INITDISK}

        # *********** 1 ************

        echo "1. Copying linuxrc"
        cp ${PORTDIR}/sys-apps/bootdisk/files/linuxrc .
        strip linuxrc

        # *********** 2 ************

        echo "2. Creating basic dirs"
        dodirs dev distcd etc mnt proc root tmp var

        # *********** 3 ************

        echo "3. Populating /dev"
        cd dev
        for i in console fd0 fd0u1440 hda hdb hdc hdd hde hdf hdg hdh loop0 ram0 \
                scd0 scd1 scd2 scd3 scd4 scd5 scd6 scd7 initrd
        do
            cp -a ${BOOTIMG}/dev/$i .
        done
	mknod -m 666 tty c 5 0
        mknod -m 600 tty1 c 4 1
        mknod -m 600 tty2 c 4 2
        mkfifo -m 600 initctl
        mkdir pts
	# Just for testing
	cp -a ${BOOTIMG}/dev/hda2 .

        # *********** 4 ************

        echo "4. Populating /etc"
        cd ../etc
        cp -af ${BOOTDIR}/files/etc/* .
	mv ${BOOTIMG}/etc/modules .
        find . -type d -name "CVS" -exec rm -r {} \; &>/dev/null
        cp ${BOOTIMG}/initrd/etc/ld.so.conf .
        cp ${BOOTIMG}/initrd/etc/ld.so.cache .

        # *********** 5 ************

        echo "5. Creating /mnt dirs"
        cd ../mnt
        dodirs floppy gentoo ram

        # *********** 6 ************

        echo "6. Populating /var"
        cd ../var
        cp -a ${BOOTIMG}/var/* .

	# *********** 7 ************

	echo
	echo "7. initrd successfully created in ${INITDISK}"
	echo

}

if [ -d ${BROOT} ]
then
  rm -r ${BROOT}
  mkdir ${BROOT}
fi

cd ${BROOT}

dodirs ${BOOTIMG} ${INITDISK} kernel mnt
echo ">>> Unpacking kernel package"
echo

tar xjf ${KERNEL} -C ${BROOT}/kernel || exit 1

mkbootimg
mkinitrd

cd ${BROOT}

echo ">>> Generating boot.img"
dd if=/dev/zero of=boot.img bs=1024 count=18000
mke2fs boot.img
mount -o loop ${BROOT}/boot.img ${BROOT}/mnt
cp -af ${BOOTIMG}/* ${BROOT}/mnt
umount ${BROOT}/mnt
echo

echo ">>> Generating initdisk"
dd if=/dev/zero of=initdisk bs=1024 count=4096
mke2fs initdisk
mount -o loop ${BROOT}/initdisk ${BROOT}/mnt
cp -af ${INITDISK}/* ${BROOT}/mnt
umount ${BROOT}/mnt
gzip -9 initdisk
echo

