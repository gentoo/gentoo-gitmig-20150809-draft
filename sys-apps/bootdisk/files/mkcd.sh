#!/bin/sh

if [ -z "$ROOT" ]
then
   echo "ROOT not set !"
   exit 1
fi

export PORTDIR=/usr/portage
export BOOTIMG=${ROOT}/bootcd
export INITDISK=${ROOT}/initdisk


if [ ! -d "${PORTDIR}/gentoo-x86/sys-apps/bootdisk" ]
then
  echo "Sorry no bootdisk in the cvs tree !"
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
    strip $i
  done
}

dodirs ${BOOTIMG} ${INITDISK}

cd ${BOOTIMG}

echo "Creating basic dirs"

dodirs bin dev initrd lib mnt proc sbin usr 


echo "Creating initdisk stuff in initrd first"

echo "Creating /initrd dirs"
cd ${BOOTIMG}/initrd

dodirs dev distcd lib etc root tmp var

touch distcd

echo "Creating /inird devices"

cd ${BOOTIMG}/initrd/dev
for i in console fd0 fd0u1440 hd[abcd] initctl loop0 ram0 scd[01] tty[01]
do
  cp -a /dev/$i .
done

mkdir pts

echo "Populating /initrd/etc"
cd ${BOOTIMG}/initrd/etc
cp -af ${PORTDIR}/gentoo-x86/sys-apps/bootdisk/files/etc/* .
find . -type d -name "CVS" -exec rm -r {} \;
touch ld.so.conf

echo "Creating linuxrc"
cd ${BOOTIMG}/initrd
gcc -s -o linuxrc ${PORTDIR}/gentoo-x86/sys-apps/bootdisk/files/linuxrc.c

cd ${BOOTIMG}/initrd/var
dodirs log run
touch log/wtmp
touch run/utmp



echo "Creating links to initrd"
cd ${BOOTIMG}

for i in etc root tmp var
do
  ln -s initrd/$i $i
done

echo "Creating devices"
cd ${BOOTIMG}/dev
ln -s ../initrd/pts pts
ln -sf ../initrd/dev/initctl .
ln -sf ../initrd/dev/tty1 .
ln -sf ../initrd/dev/tty2 .

for i in console fd0 fd0u1440 hd[abcd]* kmem loop[012] \
         mem null ptmx ram[01234] scd* sd[abcd]* ttyp[01] ttys[01] \
	 urandom zero
do
    cp -af /dev/$i .
done

ln -s ram0 ram
mknod initrd b 1 250

echo "Creating /mnt dirs"
cd ${BOOTIMG}/mnt

dodirs floppy gentoo ram

ln -s ../initrd/distcd .

cd ${BOOTIMG}/bin

echo "Populating /bin"
doexes bash cat chgrp chmod chown cp df du hostname kill ln login \
	 ls mkdir mknod mount mv ping ps rm umount uname

ln -s bash sh

echo "Populating /sbin"

cd ${BOOTIMG}/sbin

doexes agetty depmod e2fsck fdisk halt ifconfig init insmod \
	 ldconfig lilo ln lsmod mke2fs mkraid mkreiserfs mkswap \
	 portmap raidstart reboot resize2fs \
	 route sfdisk shutdown touch

# reiserfsck and resize_reiserfs does not exist in 2.4

ln -s insmod modprobe
ln -s mkraid raid0run
ln -s raidstart raidhotadd 
ln -s raidstart raidhotremove
ln -s raidstart raidstop

cp /usr/portage/gentoo-x86/autoinstaller.sh .

echo "Creating /usr dirs"
cd ${BOOTIMG}/usr

dodirs bin lib sbin share
echo "Populating /usr/bin"
cd ${BOOTIMG}/usr/bin

doexes awk bzip2 cut expr fdformat ftp grep gzip joe killall ldd \
	loadkeys most rm rmdir scp sed ssh tar top vi 

echo "Populating /usr/sbin"
cd ${BOOTIMG}/usr/sbin

doexes rc-update

echo "Populating /usr/share"
cd ${BOOTIMG}/usr/share

echo "keymaps"
cp -af /usr/share/keymaps .
echo "tabset"
cp -af /usr/share/tabset .
echo "terminfo"
cp -af /usr/share/terminfo .

echo "Populating /lib/modules"
cd ${BOOTIMG}/lib
cp -af /lib/modules .
cd ${BOOTIMG}/lib/modules/2*
for i in modules.* 
do
  rm $i
  ln -sf ../../../initrd/lib/modules/current/$i .
done

echo "Populating /usr/lib/security"
cd ${BOOTIMG}/usr/lib

mkdir security

cp /usr/lib/security/pam_permit.so .

for j in "/bin" "/sbin" "/usr/bin" "/usr/sbin"
do

    echo "Finding required libs for $j"

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
	      strip ${BOOTIMG}/usr/lib/$i
          else
              echo "$i not found !"
          fi
      fi
  done

done

ldconfig -r ${BOOTIMG}
mv ${BOOTIMG}/initrd/* ${INITDISK}
