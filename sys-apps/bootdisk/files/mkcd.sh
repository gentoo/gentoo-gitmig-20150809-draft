#!/bin/sh

export PATH=/usr/lib/portage/bin:${PATH}

if [ -z "$ROOT" ]
then
   echo "ROOT not set !"
   exit 1
fi

eval `import-settings PORTDIR`
export BOOTIMG=${ROOT}/bootcd
export INITDISK=${ROOT}/initrd
export PORTDIR=$PORTDIR/gentoo-x86

if [ -d ${BOOTIMG} ]
then
  rm -r ${BOOTIMG}
fi

if [ -d ${INITDISK} ]
then
  rm -r ${INITDISK}
fi

if [ ! -d "${PORTDIR}/sys-apps/bootdisk" ]
then
  echo "Sorry no bootdisk in the cvs tree $PORTDIR !"
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

dodirs bin dev initrd lib sbin usr 


echo "Creating initdisk stuff in initrd first"

echo "Creating /initrd dirs"
cd ${BOOTIMG}/initrd

dodirs dev proc distcd etc root tmp var mnt
cd mnt
dodirs floppy gentoo ram boot
ln -sf /initrd/distcd .

cd ..
ln -sf mnt/boot boot
echo "Creating /initrd devices"

cd ${BOOTIMG}/initrd/dev
for i in tty[01]
do
  cp -a /dev/$i .
done

mkdir pts

echo "Populating /initrd/etc"
cd ${BOOTIMG}/initrd/etc
cp -af ${PORTDIR}/sys-apps/bootdisk/files/etc.boot/* .
rm -r CVS
touch ld.so.conf

echo "Creating other dirs for initrd"
cd ${BOOTIMG}/initrd/var
dodirs log run
touch log/wtmp
touch run/utmp


echo "Creating links to initrd"
cd ${BOOTIMG}

for i in etc root tmp var mnt proc
do
  ln -s initrd/$i $i
done

echo "Creating devices"
cd ${BOOTIMG}/dev
ln -s ../initrd/pts pts
ln -sf ../initrd/dev/initctl .
ln -sf ../initrd/dev/tty1 .
ln -sf ../initrd/dev/tty2 .

#add more scsi disks!! :)

for i in console fd0 fd0u1440 hd[abcd]* kmem loop[012] \
         mem null ptmx pty* ram[01234] random rtc scd* sd[abcd]* \
	 stdin stdout stderr ttyp[01] ttys[01] \
	 urandom zero
do
    cp -af /dev/$i .
done

/dev/MAKEDEV hde
/dev/MAKEDEV hdf
/dev/MAKEDEV hdg
/dev/MAKEDEV hdh
ln -s ram0 ram
mknod initrd b 1 250

cd ${BOOTIMG}/bin

echo "Populating /bin"
doexes bash cat chgrp chmod chown cp df du hostname kill ldd ln login \
	 ls mkdir mknod mount mv ping ps rm umount uname

ln -s bash sh

echo "Populating /sbin"

cd ${BOOTIMG}/sbin

doexes agetty cfdisk depmod e2fsck fdisk grub halt ifconfig init insmod \
	 ldconfig lilo ln lsmod mke2fs mkraid mkreiserfs mkswap portmap \
	 raidstart reboot resize2fs \
	 route rpc.statd sfdisk shutdown touch
# portmap? removed; Ups added again
# reiserfsck and resize_reiserfs does not exist in 2.4

ln -s insmod modprobe
ln -s mkraid raid0run
ln -s raidstart raidhotadd 
ln -s raidstart raidhotremove
ln -s raidstart raidstop

cp ${PORTDIR}/autoinstaller.sh .
cp ${PORTDIR}/sys-apps/bootdisk/files/sbin/rc . .

echo "Creating /usr dirs"
cd ${BOOTIMG}/usr

dodirs bin lib sbin share
echo "Populating /usr/bin"
cd ${BOOTIMG}/usr/bin

doexes awk bzip2 cut expr fdformat ftp grep gzip joe killall \
	loadkeys most rm rmdir scp sed sleep ssh strace tar top vi 

echo "Populating /usr/sbin"
cd ${BOOTIMG}/usr/sbin

doexes rc-update
echo "Population /usr/lib"
cp /usr/lib/joerc ${BOOTIMG}/usr/lib

echo "Populating /usr/share"
cd ${BOOTIMG}/usr/share

echo "keymaps"
cp -af /usr/share/keymaps .
echo "tabset"
cp -af /usr/share/tabset .
echo "terminfo"
cp -af /usr/share/terminfo .

cd ${BOOTIMG}/usr/lib

cp /usr/lib/security/pam_permit.so .
cp /lib/libnss_files.so.2 .

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

ldconfig -r ${BOOTIMG} -f /initrd/etc/ld.so.conf

echo "Building initdisk"

cd ${INITDISK}

echo "Creating linuxrc"
cp ${PORTDIR}/sys-apps/bootdisk/files/linuxrc .
strip linuxrc

for i in dev distcd etc mnt proc root tmp var
do 
  mkdir ${i}
done

cd dev
for i in console fd0 fd0u1440 hd[abcd] initctl loop0 ram0 scd[01] tty[01]
do
  cp -a /dev/$i .
done
mknod initrd b 1 250

mkdir pts

cd ../etc
echo "Populating /etc"
cp -af ${PORTDIR}/sys-apps/bootdisk/files/etc/* .
find . -type d -name "CVS" -exec rm -r {} \;
cp ${BOOTIMG}/initrd/etc/ld.so.conf .
cp ${BOOTIMG}/initrd/etc/ld.so.cache .

cd ../mnt
for i in floppy gentoo ram
do
  mkdir ${i}
done

cd ../var
cp -a ${BOOTIMG}/var/* .

cd ${ROOT}

dd if=/dev/zero of=initdisk bs=1024 count=4096
mke2fs -m 0 -N 3000 initdisk
mkdir mnt
mount -o loop initdisk mnt
cp -af ${INITDISK}/* mnt
umount mnt
gzip -9 initdisk

dd if=/dev/zero of=boot.img bs=1024 count=16384
mke2fs boot.img
mkdir mnt
mount -o loop boot.img mnt
cp -af ${BOOTIMG}/* mnt
umount mnt
gzip -9 boot.img




