#!/bin/bash

# New stuff
#make ramdisk
# dd if=/dev/zero of=ramdisk bs=1k count=3700
# losetup /dev/loop2 ramdisk
# mke2fs -N1300 -vm0 /dev/loop2 3700
# mount /dev/loop2 /mnt/cdrom/
# cp -ax /tmp/root/. /mnt/cdrom/.
# Errors?
# dumpe2fs /dev/loop2
#  ...
#    0 free blocks, 3885 free inodes, 35 directories
#    Free blocks: 
#    Free inodes: 212-4096
	

# Functions
usage() {

	cat <<_EOF_
Generates a bootable image. The commandline arguments are the files 
to put in the root filesystem of the CD.

You can define these variables to override the defaults:

TEMP			Temporary files, defaults to /var/tmp/cd-build
CDROOT			Where we're going to put our CD root, defaults to
				\$TEMP/cdroot

CDOUT			The output ISO image, default \$TEMP/build.iso

PORTAGE			Defaults to /usr/portage
PROFILE_SPARC	Defaults to profiles/default-sparc-1.0 (in PORTAGE)
PROFILE_SPARC64	Defaults to profiles/default-sparc64-1.0 (in PORTAGE)

USE_RAMDISK		Defaults to /boot/ramdisk.gz
PACKAGES		Defaults to packages.cd (in PROFILE_SPARC*)
EBUILD_SPARC	The ebuild for sparc, default boot/ebuild (in PROFILE_SPARC)
EBUILD_SPARC64	The ebuild for sparc64, default boot/ebuild (in PROFILE_SPARC64)
CONFIG_SPARC	Kernel .config, default boot/kernel-config (in PROFILE_SPARC)
CONFIG_SPARC64	Kernel .config, default boot/kernel-config (in PROFILE_SPARC64)

LOOPDEVICE		/dev/loop*, used during ramdisk creation

_EOF_

	exit 1

}

COPYFILES="$@"
 
: ${TEMP:=/var/tmp/cd-build}
: ${CDROOT:=$TEMP/cdroot}
: ${BUILDROOT:=$TEMP/buildroot}
: ${ROOT_SPARC:=$CDROOT/root-sparc}
: ${ROOT_SPARC64:=$CDROOT/root-sparc64}
: ${CDOUT:=$TEMP/build.iso}
: ${PORTAGE:=/usr/portage}
: ${PROFILE_SPARC:=$PORTAGE/profiles/default-sparc-1.0}
: ${PROFILE_SPARC64:=$PORTAGE/profiles/default-sparc64-1.0}
: ${CDIMAGE_SPARC:=$PORTAGE/profiles/cdimage-sparc}
: ${CDIMAGE_SPARC64:=$PORTAGE/profiles/cdimage-sparc64}
: ${USE_RAMDISK:=/boot/ramdisk.gz}
: ${PACKAGES:=packages}
: ${EBUILD_SPARC:=$PROFILE_SPARC/boot/ebuild}
: ${EBUILD_SPARC64:=$PROFILE_SPARC64/boot/ebuild}
: ${CONFIG_SPARC:=$PROFILE_SPARC/boot/kernel-config}
: ${CONFIG_SPARC64:=$PROFILE_SPARC64/boot/kernel-config}
: ${ARCH_SPARC:=sparc}
: ${CHOST_SPARC:=sparc-unknown-linux-gnu}
: ${CFLAGS_SPARC:="-O2 -pipe"}
: ${CXXFLAGS_SPARC:="-O2 -pipe"}
: ${PLATFORM_SPARC:=sparc-unknown-linux-gnu}
: ${ARCH_SPARC64:=sparc64}
: ${CHOST_SPARC64:=sparc-unknown-linux-gnu}
: ${CFLAGS_SPARC64:="-O2 -pipe"}
: ${CXXFLAGS_SPARC64:="-O2 -pipe"}
: ${PLATFORM_SPARC64:=sparc64-unknown-linux-gnu}

# Less likely to be used and still likely to be there
: ${LOOPDEVICE:=/dev/loop2}
: ${SILOCONFOUT:=/boot/silo.conf}

sanity_checks() {
	# Must define these
	if [ -r $CDOUT ]
	then
		echo Will not overwrite $CDOUT, please move out of the way or redefine
		echo the CDOUT envirnment variable.
		exit 1
	fi
}

emerge_root() {

	TO=$1
	FROM=$2

	if [ ! -r $FROM ]
	then
		echo "$FROM does not exist, barfing"
		exit 1
	fi

	ROOT=$TO USE="-* build" ARCH=$MYARCH CHOST=$MYCHOST PLATFORM=$MYPLATFORM \
	CFLAGS=$MYCFLAGS CXXFLAGS=$MYCXXFLAGS \
		emerge --noreplace `cat $FROM` || exit 1
}

baselayout() {
	TO=$1

	mkdir -p ${TO}/usr/bin ${TO}/usr/local ${TO}/usr/sbin ${TO}/usr/lib \
		${TO}/usr/sbin ${TO}/usr/include ${TO}/usr/src ${TO}/usr/portage \
		${TO}/usr/share ${TO}/var/run ${TO}/var/lock ${TO}/var/log \
		${TO}/var/db ${TO}/var/spool ${TO}/var/tmp ${TO}/var/lib/misc \
		${TO}/home ${TO}/opt ${TO}/root ${TO}/proc ${TO}/tmp ${TO}/etc \
		${TO}/lib/modules ${TO}/mnt/floppy ${TO}/mnt/cdrom ${TO}/mnt/hd \
		${TO}/mnt/gentoo ${TO}/dev ${TO}/bin ${TO}/sbin

	ln -s ../proc/filesystems ${TO}/etc/filesystems
	cd ${TO}/dev
	/usr/sbin/MAKEDEV generic-sparc sg scd rtc audio hde hdf hdg hdh
	cd -
	
}

compile_kernel_arch() {
	KARCH=$1
	if [ -z "$KARCH" ]
	then
		echo Function compile_kernel_arch called without ARCH argument.
		echo Barfing
		exit 1
	fi

	# install
	cd ${PORTAGE}/${KERNEL_TREE} || exit 1

	ebuild $MYEBUILD unpack || exit 1

	cd ${KERNEL_ROOT} || exit 1
	
	cp $MYCONFIG .config
	
	yes n | make ARCH=$KARCH oldconfig
	make ARCH=$KARCH dep clean vmlinux modules
	cd /
}
	

copy_kernel() {

	KARCH=$1
	TO=$2

	strip -R .note -R .comment ${KERNEL_ROOT}/vmlinux
	cat ${KERNEL_ROOT}/vmlinux | gzip -v9 > ${TO}/vmlinuz \
		|| exit 1
}

copy_modules() {

	KARCH=$1
	TO=$2

	cd ${KERNEL_ROOT}
	make ARCH=$KARCH INSTALL_MOD_PATH=$TO modules_install || exit 1
	cd /
}

copy_clean() {

	#rm -rf ${KERNEL_ROOT}
	echo Not cleaning
}

copy_files() {

	KARCH=$1
	TO=$2

	case $KARCH in
		sparc64)
				PROFILE=$PROFILE_SPARC64
				;;
		sparc)
				PROFILE=$PROFILE_SPARC
				;;
	esac

	# Generate /
	baselayout $TO
	
	# Copy the binaries, etc
	find /var/db/pkg -name CONTENTS -type f |\
		egrep -f ${PROFILE}/${PACKAGES} | \
		xargs egrep -e  '(/bin|/usr/bin|/sbin|/usr/sbin|/etc)' | \
		egrep -v ':dir ' |egrep -v 'MAKEDEV' | awk '{print $2}' | \
		egrep -v '(/[.]keep$|/usr/src)' > ${TEMP}/filelist

	#find /usr/share/terminfo -name vt\* -o -name linux -o -name sun\* -o \
							#-name \*onsole\* -o -name xterm >> ${TEMP}/filelist
	find /usr/share/terminfo -type f |egrep -v 'pmconsole' >> ${TEMP}/filelist
	tar -c --numeric-owner -T ${TEMP}/filelist -f - | ( cd $TO; tar xf - )
	
	# Copy the libraries we need
	find $TO -type f | xargs file | grep ELF | awk -F: '{print $1}' |xargs ldd | grep -v '.*:$' | awk '{print $3}' | sort -u | xargs ls -al | awk '{print $9 "\n/lib/" $11 "\n/usr/lib/" $11 }' | egrep -v '/.*/$' > ${TEMP}/filelist

	ls /lib/libnss_* >> ${TEMP}/filelist

	tar -c --numeric-owner -T ${TEMP}/filelist -f - | ( cd $TO; tar xf - )

	# Remove stuff we dont need
	find ${TO}/var -type f | xargs rm
	
	rm -rf ${TO}/var/db/pkg/* ${TO}/usr/X11* ${TO}/usr/local
	# Procps
	rm ${TO}/usr/bin/{top,oldps,tload,w}
	# Util-linux, silo
	rm ${TO}/usr/bin/{tilo,maketilo,ul} ${TO}/usr/sbin/silocheck

	# Fileutils
	rm -rf ${TO}/bin/vdir ${TO}/usr/bin/vdir ${TO}/usr/bin/sha1sum

	# General
	rm -rf ${TO}/usr/share/man ${TO}/usr/share/doc ${TO}/usr/include
		
	

	# Some special fixes

	# KEYMAP fix
	sed 's/KEYMAP=".*"/# KEYMAP="sun"/' ${TO}/etc/rc.conf > ${TO}/etc/rc.conf.new
	mv ${TO}/etc/rc.conf.new ${TO}/etc/rc.conf

	#cp -a /usr/share/terminfo ${TO}/usr/share/
	mkdir -p ${TO}/mnt/.init.d/started

	cat >> ${TO}/etc/init.d/checkroot <<_EOF_
#!/sbin/runscript

depend() {
	before *
}
		
start() {
	mount -a
}
_EOF_
			
	cat >> ${TO}/etc/inittab <<_EOF_

# Added automatically:
#
# Allow serial A console connection, copy and replace T0 with T1 for serial B
T0:12345:respawn:/sbin/agetty 9600  ttyS0 vt100
_EOF_


	cat > $TO/etc/fstab <<_EOF_
# /etc/fstab: static file system information.
#
# noatime turns of atimes for increased performance (atimes normally aren't
# needed; notail increases performance of ReiserFS (at the expense of storage
# efficiency).  It's safe to drop the noatime options if you want and to 
# switch between notail and tail freely.

# <fs>          	<mountpoint>    <type>  	<opts>      		<dump/pass>

# NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
#/dev/BOOT			/boot			ext2		noauto,noatime		1 1
#/dev/ROOT			/				xfs			noatime				0 0
#/dev/SWAP			none			swap		sw					0 0
/dev/cdroms/cdrom0	/mnt/cdrom		iso9660		noauto,ro			0 0
proc				/proc			proc		defaults			0 0
tmpfs				/tmp			tmpfs		defaults			0 0
tmpfs				/dev/shm		tmpfs		defaults			0 0
_EOF_


}
		
install_silo() {

	TO=$1

	mkdir -p ${TO}/boot
	cp -p /boot/*.b ${TO}/boot
	cat > ${TO}/boot/welcome.txt <<_EOF_
-- Welcome to Gentoo SPARC Linux --
_EOF_

	cat > ${TO}/boot/help.txt <<_EOF_
You are running the second stage SILO loader.  From here you can boot a
ramdisk or an already-installed Linux partition.

Several defaults have been defined that will make things easier. The 
target "ramdisk" will start a kernel and ramdisk which 
will allow you to install a new system or fix a broken one.

The "vmlinuz" target will give you a standard kernel for your OS, you'll
need to provide the name of the root device so the system knows what to
go do with itself. By default the kernel will attempt to netboot from NFS.

boot: vmlinuz root=/dev/sda1

Type "help" for help on using SILO.  Type "config" to see the SILO config file.
_EOF_

	mkdir -p ${TO}/etc
	cat > ${TO}${SILOCONFOUT}    <<_EOF_
default="gentoo"
message="/boot/welcome.txt"

# Images
image="cat /boot/help.txt"
	label="gentoo"

image="cat ${SILOCONFOUT}"
	label="config"

image[sun4c,sun4d,sun4m]="/boot/sparc/vmlinuz"
	label="ramdisk"
	initrd="/boot/ramdisk.gz"
	root="/dev/ram0"

image[sun4u]="/boot/sparc64/vmlinuz"
	label="ramdisk"
	initrd="/boot/ramdisk.gz"
	root="/dev/ram0"

image[sun4c,sun4d,sun4m]="/boot/sparc/vmlinuz"
	label="vmlinuz"

image[sun4u]="/boot/sparc64/vmlinuz"
	label="vmlinuz"

_EOF_

	cp /README.maintainer ${TO}
}

create_ramdisk() {

	FROM=$1
	TO=$2

	SIZE=`du -sk $FROM/. | awk '{print $1}'`

	# a 35 MB ramdisk?
	if [ $SIZE -gt 35000 ]
	then
		echo Ramdisk of directory $FROM would be too large:
		echo $SIZE KB. Bailing out.
		exit 1
	fi

	NEWSIZE=`echo $SIZE + 500 | bc`
	# Otherwise we get "short writes"
	SAFESIZE=`echo $NEWSIZE - 10 | bc`
	DISKSIZE=`echo "(($NEWSIZE /1024)+1)*1024" | bc`

	mkdir -p $TEMP/ramdisk || exit 1

	dd if=/dev/zero of=${TO}/ramdisk bs=1k count=$NEWSIZE || exit 1
	losetup $LOOPDEVICE ${TO}/ramdisk || exit 1
	mke2fs -vm0 $LOOPDEVICE $SAFESIZE || exit 1
	mount $LOOPDEVICE ${TEMP}/ramdisk || exit 1

	cp -ax $FROM/.  $TEMP/ramdisk/.	  || exit 1
	umount $TEMP/ramdisk			  || exit 1
	losetup -d $LOOPDEVICE			  || exit 1
	touch $TO/ramdisk
	gzip -v9 ${TO}/ramdisk
}

buildroot() {
	KARCH=$1
	
	case $KARCH in
		sparc64)
			MYROOT=$ROOT_SPARC64
			MYCDROOT=${CDROOT}/boot/sparc64
			MYCDIMAGE=${CDIMAGE_SPARC64}
			;;
		sparc)
			MYROOT=$ROOT_SPARC
			MYCDROOT=${CDROOT}/boot/sparc
			MYCDIMAGE=${CDIMAGE_SPARC}
			;;
	esac

	#copy_files ${KARCH} ${MYROOT}
	mkdir -p ${MYROOT}
	emerge_root ${MYROOT} ${MYCDIMAGE}/${PACKAGES}
	find ${MYROOT}/bin ${MYROOT}/sbin ${MYROOT}/usr/bin ${MYROOT}/usr/sbin -type f | xargs file| grep "not stripped" | cut -d: -f1| xargs strip
	find ${MYROOT}/lib ${MYROOT}/usr/lib -type f | xargs file| grep "not stripped" | cut -d: -f1| xargs strip --strip-debug
	if [ ! -r ${KERNEL_ROOT}/vmlinux ]; then
		compile_kernel_arch ${KARCH}
		mkdir -p ${MYCDROOT}
		copy_kernel ${KARCH} ${MYCDROOT}
		copy_modules ${KARCH} ${MYROOT}
	fi
	copy_clean ${KARCH}
	umount ${MYROOT}/mnt/.init.d

if [ 0 -gt 1 ]
then
	cat > ${MYROOT}/etc/passwd <<_EOF_
root:x:0:0::/root:/bin/bash
bin:x:1:1:bin:/bin:/bin/false
daemon:x:2:2:daemon:/sbin:/bin/false
adm:x:3:4:adm:/var/adm:/bin/false
lp:x:4:7:lp:/var/spool/lpd:/bin/false
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/bin/false
news:x:9:13:news:/usr/lib/news:/bin/false
uucp:x:10:14:uucp:/var/spool/uucppublic:/bin/false
operator:x:11:0:operator:/root:/bin/bash
games:x:12:22:games:/usr/games:/bin/false
man:x:13:15:man:/usr/man:/bin/false
postmaster:x:14:12:postmaster:/var/spool/mail:/bin/bash
cron:x:16:16:cron:/var/cron:/bin/bash
_EOF_
	chmod 0644 ${MYROOT}/etc/passwd
	chown root:root ${MYROOT}/etc/passwd

	cat > ${MYROOT}/etc/shadow <<_EOF_
root::11796:0:::::
halt:*:9797:0:::::
operator:*:9797:0:::::
shutdown:*:9797:0:::::
sync:*:9797:0:::::
bin:*:9797:0:::::
ftp:*:9797:0:::::
daemon:*:9797:0:::::
adm:*:9797:0:::::
lp:*:9797:0:::::
mail:*:9797:0:::::
postmaster:*:9797:0:::::
news:*:9797:0:::::
uucp:*:9797:0:::::
man:*:9797:0:::::
games:*:9797:0:::::
guest:*:9797:0:::::
nobody:*:9797:0:::::
_EOF_
	chmod 0600 ${MYROOT}/etc/shadow
	chown root:root ${MYROOT}/etc/shadow

	cat > ${MYROOT}/etc/group <<_EOF_
nogroup::65533:
root::0:root
bin::1:root,bin,daemon
daemon::2:root,bin,daemon
sys::3:root,bin,adm
adm::4:root,adm,daemon
tty::5:
disk::6:root,adm
lp::7:lp
mem::8:
kmem::9:
wheel::10:root,maarten
floppy::11:root
mail::12:mail
news::13:news
uucp::14:uucp
man::15:man
cron::16:cron
console::17:
audio::18:
cdrom::19:
dialout::20:root
ftp::21:
games::22:
at::25:at
tape::26:root
video::27:root
squid::31:squid
gdm::32:gdm
xfs::33:xfs
named::40:named
mysql:x:60:
postgres::70:
cdrw::80:
users::100:games
nofiles:x:200:
qmail:x:201:
postfix:x:207:
postdrop:x:208:
utmp:x:406:
nobody::65534:
apache:x:407:
_EOF_

	chmod 0644 ${MYROOT}/etc/group
    chown root:root ${MYROOT}/etc/group
fi
}

do_sparc() {
	MYEBUILD=${PORTAGE}/`cat ${EBUILD_SPARC}`
	MYCONFIG=$CONFIG_SPARC
	PORTAGE_TMPDIR=${BUILDROOT}/sparc
	export PORTAGE_TMPDIR
	DIR_NAME=`basename $MYEBUILD | sed 's/\.ebuild//'`
	KERNEL_ROOT=${PORTAGE_TMPDIR}/portage/${DIR_NAME}/work/*
	MYARCH=$ARCH_SPARC
	MYCHOST=$CHOST_SPARC
	MYPLATFORM=$PLATFORM_SPARC
	MYCFLAGS=$CFLAGS_SPARC
	MYCXXFLAGS=$CXXFLAGS_SPARC
	buildroot $MYARCH
	#create_ramdisk $ROOT_SPARC ${CDROOT}/boot/$MYARCH
	SPARC_DISKSIZE=$DISKSIZE
}

do_sparc64() {
	MYEBUILD=${PORTAGE}/`cat ${EBUILD_SPARC64}`
	MYCONFIG=$CONFIG_SPARC64
	PORTAGE_TMPDIR=${BUILDROOT}/sparc64
	export PORTAGE_TMPDIR
	DIR_NAME=`basename $MYEBUILD | sed 's/\.ebuild//'`
	KERNEL_ROOT=${PORTAGE_TMPDIR}/portage/${DIR_NAME}/work/*
	MYARCH=$ARCH_SPARC64
	MYCHOST=$CHOST_SPARC64
	MYPLATFORM=$PLATFORM_SPARC64
	MYCFLAGS=$CFLAGS_SPARC64
	MYCXXFLAGS=$CXXFLAGS_SPARC64
	buildroot sparc64
	#create_ramdisk $ROOT_SPARC64 ${CDROOT}/boot/sparc64
	SPARC64_DISKSIZE=$DISKSIZE
}

create_root() {

	do_sparc
	do_sparc64
	
	install_silo $CDROOT

	# Copy the files we were asked
	cp -ax $COPYFILES ${CDROOT}

}

create_cd() {
	chown -Rh root:root ${CDROOT}
	cd ${CDROOT}
	cp $USE_RAMDISK boot
	mkisofs.debian -v -r -S boot/cd.b -s ${SILOCONFOUT} -o ${CDOUT} .
	cd /
}

sanity_checks
create_root
create_cd


echo "Now you can mount the ISO image like this:"
echo ""
echo "mount -t iso9660 -o loop ${CDOUT} /mnt/cdrom"
