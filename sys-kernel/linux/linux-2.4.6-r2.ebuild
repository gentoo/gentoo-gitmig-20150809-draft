# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.4.6-r2.ebuild,v 1.6 2001/08/07 18:05:49 drobbins Exp $

#OKV=original kernel version, KV=patched kernel version

OKV=2.4.6
KV=2.4.6
S=${WORKDIR}/linux-${KV}
S2=${WORKDIR}/linux-${KV}-extras
if [ $PN = "linux-extras" ] || [ $PN = "linux-headers" ]
then
	KS=/usr/src/linux-${KV}
	KS2=/usr/src/linux-${KV}-extras
else
	KS=${S}
	KS2=${S2}
fi

# Kernel Features      Enabled   USE Variable      Status
#
# Reiserfs             Y         -                 Production-ready
# JFS                  N         jfs               Testing-only (commented out for now)
# LVM                  Y         lvm               almost production-ready (still has race conditions during pvmove)
# ext3                 Y         ext3              Production-ready
# MOSIX                Y         mosix             Testing only
# XFS                  N         xfs               Will add soon
# PCMCIA-CS            N         pcmcia            Need to move this to its own ebuild
# lm-sensors           N         lm_sensors        Need to move this to its own ebuild

LVMV=0.9.1_beta7
EXT3V=2.4-0.9.2-246
MOSV=1.1.2
CLOOPV=0.61
CLOOPAV=0.61-1
# AV=0.5.11
#JFSV=1.0.0
#KNV="6.g"
#PIV="1.d"
#PCV="3.1.27"

[ "${PN}" = "linux" ] && DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
[ "${PN}" = "linux-sources" ] && DESCRIPTION="Linux kernel version ${KV} - full sources"
[ "${PN}" = "linux-extras" ] && DESCRIPTION="Linux kernel support tools and libraries"

# We use build in /usr/src/linux in case of linux-extras
# so we need no sources

#Please do not add mosix to the SRC_URI -- it's not supported yet. --drobbins

if [ ! "${PN}" = "linux-extras" ] ; then
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.zip.com.au/~akpm/ext3-${EXT3V}.gz
	http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-1.0.0-patch.tar.gz
	ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_${LVMV}.tar.gz
    http://www.knopper.net/download/knoppix/cloop_${CLOOPAV}.tar.gz"
fi
#	http://www.netroedge.com/~lm78/archive/lm_sensors-${SENV}.tar.gz
#	http://www.netroedge.com/~lm78/archive/i2c-${SENV}.tar.gz
#	http://prdownloads.sourceforge.net/pcmcia-cs/pcmcia-cs-${PCV}.tar.gz
#	ftp://ftp.cs.huji.ac.il/users/mosix/MOSIX-${MOSV}.tar.gz
	
if [ "$PN" != "linux-extras" ]
then
	PROVIDE="virtual/kernel"
fi

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/"

DEPEND=">=sys-apps/modutils-2.4.2 sys-devel/perl"
#these deps are messed up; fix 'em and add ncurses (required my mosix compile, menuconfig)
if [ $PN = "linux" ]
then
	RDEPEND="mosix? ( ~sys-apps/mosix-user-${MOSV} ) >=sys-apps/e2fsprogs-1.22 >=sys-apps/util-linux-2.11f >=sys-apps/reiserfs-utils-3.6.25-r1"
elif [ $PN = "linux-sources" ]
then
	if [ "`use build`" ]
	then
		DEPEND=""
		RDEPEND=""
	else
		#ncurses is required for "make menuconfig"
		RDEPEND=">=sys-libs/ncurses-5.2"
	fi
elif [ $PN = "linux-extras" ] || [ $PN = "linux-headers" ]
then
	#linux-extras/headers requires a rev of the current kernel sources to be installed
	DEPEND="~sys-kernel/linux-sources-${PV}"
fi

# this is not pretty...
LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${KS}/include"

src_unpack() {
	if [ "$PN" = "linux-extras" ] || [ "$PN" = "linux-headers" ]
	then
		return
	fi

    mkdir ${S2}

	#unpack kernel and apply reiserfs-related patches
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	try mv linux linux-${KV}
	cd ${S}
	if [ "$KV" != "$OKV" ]
	then
		echo "Applying ${KV} patch..."
		try bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
	fi
#		This patch is just *too* unweildy and creates tons of rejects all over the place (boo!)
#		echo "Applying XFS patch..."
#		local x
#		for x in easy only tricky acl-extattr misc
#		do
#			cat ${DISTDIR}/patch-2.4.6-xfs-${x}.bz2 | bzip2 -d | patch -p1
#		done		
	
	dodir /usr/src/linux-${KV}-extras

	if [ "`use mosix`" ]
	then
		echo "Applying MOSIX patch..."
		cd ${S2}
		mkdir MOSIX-${MOSV}
		cd MOSIX-${MOSV}
		tar xzf MOSIX-${MOSV}.tar.gz patches.${OKV} kernel.new.${OKV}.tar
		cd ${S}
		try cat ${S2}/MOSIX-${MOSV}/patches.${KV} | patch -p0
		tar -x --no-same-owner -vf ${S2}/MOSIX-${MOSV}/kernel.new.${KV}.tar
	fi
	
	cd ${S}
	echo "Applying reiserfs-NFS fix..."
	try cat ${FILESDIR}/${PVR}/linux-${KV}-reiserfs-NFS.patch | patch -N -p1
			
	if [ "`use lvm`" ]
	then
		#create and apply LVM patch.  The tools get built later.
		cd ${S2}
		echo "Unpacking and applying LVM patch..."
		unpack lvm_${LVMV}.tar.gz
		try cd LVM/${LVMV}

		# I had to hack this in so that LVM will look in the current linux
		# source directory instead of /usr/src/linux for stuff - pete
		CFLAGS="${CFLAGS} -I${S}/include" try ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
		cd PATCHES
		try make KERNEL_VERSION=${KV} KERNEL_DIR=${S}
		cd ${S}
		# the -l option allows this patch to apply cleanly (ignore whitespace changes)
		try patch -l -p1 < ${S2}/LVM/${LVMV}/PATCHES/lvm-${LVMV}-${KV}.patch
		cd ${S}/drivers/md
		try patch -p0 < ${FILESDIR}/${PVR}/lvm.c.diff
	fi

#		if [ "`use lm_sensors`" ]
#		then
#			#unpack and apply the lm_sensors patch
#			echo "Unpacking and applying lm_sensors patch..."
#			cd ${S}/extras
#			unpack lm_sensors-${SENV}.tar.gz
#			unpack i2c-${SENV}.tar.gz
#			try cd i2c-${SENV}
#			try rmdir src
#			try ln -s ../.. src
#			try mkpatch/mkpatch.pl . /usr/src/linux | patch -p1 -E -d /usr/src/linux
#			cp Makefile Makefile.orig
#			try sed -e \"s:^LINUX=.*:LINUX=src:\" \
#			-e \"s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 2/\" \
#			-e \"s:^I2C_HEADERS.*:I2C_HEADERS=.i2c-src/kernel:\" \
#			-e \"s#^DESTDIR.*#DESTDIR := ${D}#\" \
#			-e \"s#^PREFIX.*#PREFIX := /usr#\" \
#			-e \"s#^MANDIR.*#MANDIR := /usr/share/man#\" \
#			Makefile.orig > Makefile
#			try cd ${S}/extras/lm_sensors-${SENV}
#			try rmdir src
#			try ln -s ../.. src
#			try ln -s ../i2c-${SENV} i2c-src
#			try mkpatch/mkpatch.pl . /usr/src/linux | patch -p1 -E -d /usr/src/linux
#			try sed -e \"s:^LINUX=.*:LINUX=src:\" \
#			-e \"s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 2/\" \
#			-e \"s:^I2C_HEADERS.*:I2C_HEADERS=.i2c-src/kernel:\" \
#			-e \"s#^DESTDIR.*#DESTDIR := ${D}#\" \
#			-e \"s#^PREFIX.*#PREFIX := /usr#\" \
#			-e \"s#^MANDIR.*#MANDIR := /usr/share/man#\" \
#			Makefile.orig > Makefile
#		 fi
#	if [ "`use pcmcia-cs`" ]
#	then
#		echo "Unpacking pcmcia-cs tools..."
#		cd ${S2}
#		unpack pcmcia-cs-${PCV}.tar.gz
	#	patch -p0 < ${FILESDIR}/${PVR}/pcmcia-cs-${PCV}-gentoo.diff
#	fi
	
	#JFS patch works; commented out because it's not ready for production use
	#if [ "`use jfs`" ]
	#then
	#	echo "Applying JFS patch..."
	#	cd ${WORKDIR}
	#	unpack jfs-${JFSV}-patch.tar.gz
	#	cd ${S}
	#	patch -p1 < ${WORKDIR}/jfs-common-v1.0.0-patch
	#	patch -p1 < ${WORKDIR}/jfs-2.4.5-v1.0.0-patch
	#fi
	
	if [ "`use ext3`" ]
	then
		echo "Applying ext3 patch..."
		if [ "`use mosix`" ]
		then
			echo
			echo "There will be one reject; we will fix it. (no worries)"
			echo
		fi
		cd ${S}
		gzip -dc ${DISTDIR}/ext3-${EXT3V}.gz | patch -l -p1
		if [ "`use mosix`" ]
		then
			echo 
			echo "Fixing reject in include/linux/sched.h..."
			echo
			cp ${FILESDIR}/${PVR}/sched.h include/linux
		fi
	fi
	
	cd ${S2}
	unpack cloop_${CLOOPAV}.tar.gz
		
	#get sources ready for compilation or for sitting at /usr/src/linux
	echo "Preparing for compilation..."
	cd ${S}
	#sometimes we have icky kernel symbols; this seems to get rid of them
	try make mrproper

	#linux-sources needs to be fully configured, too.  Not just linux
	#this is the configuration for the default kernel
	try cp ${FILESDIR}/${PVR}/config.bootcd .config
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."
    
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *
}
		
src_compile() {
	if [ "${PN}" = "linux-sources" ] || [ "${PN}" = "linux-headers" ]
	then
		cd ${KS}
		try make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" dep
	else
		if [ $PN = "linux" ]
		then
			cd ${KS}
			try make symlinks
		fi
		if [ "`use lvm`" ]
		then
			#LVM tools are included in the linux and linux-extras pakcages
			cd ${KS2}/LVM/${LVMV}
	
			# This is needed for linux-extras
			if [ -f "Makefile" ]
			then
				try make clean
			fi
			# I had to hack this in so that LVM will look in the current linux
			# source directory instead of /usr/src/linux for stuff - pete
			CFLAGS="${CFLAGS} -I${KS}/include" try ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${KS}"
			try make
		fi
	
#		if [ "`use lm_sensors`" ]
#		then
#			cd ${KS}/extras/lm_sensors-${SENV}
#			try make
#		fi
		
#		Works, just commented out because JFS isn't ready to be used by non-developers
#		if [ "`use jfs`" ]
#		then
#			cd ${S}/fs/jfs/utils
#			try make
#			cd output
#			into /
#			dosbin *
#			doman `find -iname *.8`
#		fi
			
		if [ "$PN" == "linux" ]
		then
			cd ${KS}
			try make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" dep
			try make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" LEX="flex -l" bzImage
			try make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" LEX="flex -l" modules
		fi
		
#		if [ "`use pcmcia-cs`" ]
#		then
#			cd ${KS2}/pcmcia-cs-${PCV}
#			# This is needed for linux-extras
#			if [ -f "Makefile" ] 
#			then
#				try make clean
#			fi
#			try ./Configure -n --kernel=${KS} --moddir=/lib/modules/${KV} \
#			--notrust --cardbus --nopnp --noapm --srctree --sysv --rcdir=/etc/rc.d/
#			try make all
#		fi
		
		cd ${KS2}/cloop-${CLOOPV}
		make KERNEL_DIR=${KS}
	fi
}

src_install() {
	if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
		dodir /usr/lib
	
		if [ "`use lvm`" ]
		then
			cd ${KS2}/LVM/${LVMV}/tools
	    
			CFLAGS="${CFLAGS} -I${KS}/include" try make install -e prefix=${D} mandir=${D}/usr/share/man \
			sbindir=${D}/sbin libdir=${D}/lib
			#no need for a static library in /lib
			mv ${D}/lib/*.a ${D}/usr/lib
		fi
	
#		if [ "`use lm_sensors`" ]
#		then
#			echo "Install sensor tools..."
#			#install sensors tools
#			cd ${KS}/extras/lm_sensors-${SENV}
#			make install
#		fi

		if [ "${PN}" = "linux" ] 
		then
			dodir /usr/src/linux-${KV}
			cd ${D}/usr/src
			#grab includes and documentation only
			echo ">>> Copying includes and documentation..."
			cp -ax ${S}/include ${D}/usr/src/linux-${KV}
			cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
	       
			#grab compiled kernel
			dodir /boot/boot
			insinto /boot/boot
			cd ${S}
			doins arch/i386/boot/bzImage
	    
			#grab modules
			# Do we have a bug in modutils ?
			# Meanwhile we use this quick fix (achim)
	    
			install -d ${D}/lib/modules/`uname -r`
			try make INSTALL_MOD_PATH=${D} modules_install
			
			cd ${S}
			depmod -b ${D} -F ${S}/System.map ${KV}	
			#rm -rf ${D}/lib/modules/`uname -r`
			#fix symlink
			cd ${D}/lib/modules/${KV}
			rm build
			ln -sf /usr/src/linux-${KV} build
		fi

#		if [ "`use pcmcia-cs`" ]
#		then
#			#install PCMCIA modules and utilities
#			cd ${KS2}/pcmcia-cs-${PCV}
#			try make PREFIX=${D} MANDIR=${D}/usr/share/man install  
#			rm -rf ${D}/etc/rc.d
#			exeinto /etc/rc.d/init.d
#			doexe ${FILESDIR}/${KV}/pcmcia
#		fi	    
			
		cd ${KS2}/cloop-${CLOOPV}
		insinto /lib/modules/${KV}/kernel/drivers/block
		doins cloop.o
		into /usr
		dobin create_compressed_fs extract_compressed_fs
		
		if [ "`use bootcd`" ]
		then
			rm -rf ${D}/usr/include ${D}/usr/lib/lib*.a ${D}/usr/src
		fi
		
	elif [ "$PN" = "linux-sources" ]
	then
		dodir /usr/src
		cd ${S}

		if [ "`use build`" ] ; then
			dodir /usr/src/linux-${KV}
			#grab includes and documentation only
			echo ">>> Copying includes..."
			cp -ax ${S}/include ${D}/usr/src/linux-${KV}
		else
			echo ">>> Copying sources..."
			cp -ax ${WORKDIR}/* ${D}/usr/src
		fi
	elif [ "$PN" = "linux-headers" ]
	then
		#the linux-headers package basically takes a "snapshot" of your current linux headers
		dodir /usr/include/linux
		cp -ax ${KS}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${KS}/include/asm-i386/* ${D}/usr/include/asm
	fi
	if [ -d ${D}/usr/src/linux-${KV} ]
	then
		#don't overwrite existing .config if present
		cd ${D}/usr/src/linux-${KV}
		if [ -e .config ]
		then
			cp -a .config .config.eg
		fi
	fi
}

pkg_preinst() {
	if [ "$PN" = "linux-headers" ]
	then
		if [ -L ${ROOT}usr/include/linux ]
		then
			rm ${ROOT}usr/include/linux
		fi
		if [ -L ${ROOT}usr/include/asm ]
		then
			rm ${ROOT}usr/include/asm
		fi
	fi
}

pkg_postinst() {
    rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${KV} ${ROOT}/usr/src/linux
    
    #copy over our .config if one isn't already present
    cd ${ROOT}/usr/src/linux-${KV}
    if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
    then
		cp -a .config.eg .config
    fi
}
