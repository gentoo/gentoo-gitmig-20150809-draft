# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.10.ebuild,v 1.4 2001/09/28 04:00:51 drobbins Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV=2.4.10
KV=2.4.10
S=${WORKDIR}/linux-${KV}
S2=${WORKDIR}/linux-${KV}-extras
if [ $PN = "linux-extras" ] 
then
	KS=${ROOT}usr/src/linux-${KV}
	KS2=${ROOT}usr/src/linux-${KV}-extras
else
	KS=${S}
	KS2=${S2}
fi

# Kernel Features      Enabled   USE Variable      Status
#
# Reiserfs             Y         -                 Production-ready
# JFS                  N         jfs               Testing-only (commented out for now)
# LVM                  Y         lvm               Production-ready 
# ext3                 Y         ext3              Production-ready
# MOSIX                N         mosix             Testing only, probably quite stable
# XFS                  N         xfs               will probably need to be placed in a separate kernel 
# PCMCIA-CS            N         pcmcia            Need to move this to its own ebuild
# lm-sensors           N         lm_sensors        Need to move this to its own ebuild

LVMV=1.0.1-rc2

#[ "${PN}" = "linux" ] && DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
[ "${PN}" = "linux-sources" ] && DESCRIPTION="Linux kernel version ${KV} - full sources"
#[ "${PN}" = "linux-extras" ] && DESCRIPTION="Linux kernel support tools and libraries"

# We use build in /usr/src/linux in case of linux-extras
# so we need no sources
[ ! "${PN}" = "linux-extras" ] && SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
http://www.ibiblio.org/gentoo/distfiles/lvm-${LVMV}-${KV}.patch.bz2
ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${LVMV}.tar.gz
http://www.tech9.net/rml/linux/patch-rml-2.4.10-preempt-kernel-1
http://www.tech9.net/rml/linux/patch-rml-2.4.10-preempt-ptrace-and-jobs-fix-2
http://lameter.com/kernel/ext3-2.4.10.gz"
	
[ "$PN" != "linux-extras" ] && PROVIDE="virtual/kernel"

HOMEPAGE="http://www.kernel.org/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/"

DEPEND=">=sys-apps/modutils-2.4.2 sys-devel/perl"
#these deps are messed up; fix 'em and add ncurses (required my mosix compile, menuconfig)
if [ $PN = "linux" ]
then
#	RDEPEND="mosix? ( ~sys-apps/mosix-user-${MOSV} ) >=sys-apps/e2fsprogs-1.22 >=sys-apps/util-linux-2.11f >=sys-apps/reiserfs-utils-3.6.25-r1"
	RDEPEND=">=sys-apps/e2fsprogs-1.22 >=sys-apps/util-linux-2.11f >=sys-apps/reiserfs-utils-3.6.25-r1"
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
elif [ $PN = "linux-extras" ]
then
	#linux-extras/headers requires a rev of the current kernel sources to be installed
	RDEPEND="~sys-kernel/linux-sources-${PV}"
elif [ $PN = "linux-headers" ]
then
	DEPEND=""
	RDEPEND=""
fi

# this is not pretty...
[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${KS}/include"

src_unpack() {
	[ "$PN" = "linux-extras" ] && return
	mkdir ${S2}

	#unpack kernel and apply reiserfs-related patches
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	cd ${S}
	if [ "$KV" != "$OKV" ]
	then
		echo "Applying ${KV} patch..."
		bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1 || die
	fi
	dodir /usr/src/linux-${KV}-extras

	#specific to 2.4.10; preempt and ext3 patches
	cd ${S}
	patch -p1 < ${DISTDIR}/patch-rml-2.4.10-preempt-kernel-1 || die
	patch -p1 < ${DISTDIR}/patch-rml-2.4.10-preempt-ptrace-and-jobs-fix-2 || die
	cat ${DISTDIR}/ext3-2.4.10.gz | gzip -dc | patch -p1 || die
	#the LVM patch is included to replace the old version, irregardless if USE lvm is set
	cat ${DISTDIR}/lvm-${LVMV}-${KV}.patch.bz2 | bzip2 -d | patch -N -l -p1 
	#|| die
	#we removed || die because any stuff that hits -N causes an error code of 1
	cd ${S2}
	unpack lvm_${LVMV}.tar.gz
	#get sources ready for compilation or for sitting at /usr/src/linux
	echo "Preparing for compilation..."
	cd ${S}
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#linux-sources needs to be fully configured, too.  Not just linux
	#this is the configuration for the default kernel
	cp ${PORTDIR}/sys-kernel/linux-sources/files/config.default .config || die
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."
    
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *
}
		
src_compile() {
	if [ "${PN}" = "linux-headers" ]
	then
		cd ${KS}
		make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" dep || die
	elif [ "${PN}" = "linux-sources" ]
	then
		echo
	else
		if [ $PN = "linux" ]
		then
			cd ${KS}
			make symlinks || die
			make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" dep || die
			make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" LEX="flex -l" bzImage || die
			make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" LEX="flex -l" modules || die
		fi
		#LVM tools are included in the linux and linux-extras pakcages
		cd ${KS2}/LVM/${LVMV}
	
		# This is needed for linux-extras
		if [ -f "Makefile" ]
		then
			make clean || die
		fi
		# I had to hack this in so that LVM will look in the current linux
		# source directory instead of /usr/src/linux for stuff - pete
		CFLAGS="${CFLAGS} -I${KS}/include" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${KS}" || die
		make || die
	
		if [ "$PN" == "linux" ]
		then
	fi
}

src_install() {
	if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
		dodir /usr/lib
	
		cd ${KS2}/LVM/${LVMV}/tools
		CFLAGS="${CFLAGS} -I${KS}/include" make install -e prefix=${D} mandir=${D}/usr/share/man sbindir=${D}/sbin libdir=${D}/lib || die
		#no need for a static library in /lib
		mv ${D}/lib/*.a ${D}/usr/lib
	
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
			make INSTALL_MOD_PATH=${D} modules_install || die
			
			cd ${S}
			depmod -b ${D} -F ${S}/System.map ${KV}	
			#rm -rf ${D}/lib/modules/`uname -r`
			#fix symlink
			cd ${D}/lib/modules/${KV}
			rm build
			ln -sf /usr/src/linux-${KV} build
		fi

		cd ${KS2}/cloop-${CLOOPV}
		insinto /lib/modules/${KV}/kernel/drivers/block
		doins cloop.o
		into /usr
		dobin create_compressed_fs extract_compressed_fs
		
	elif [ "$PN" = "linux-sources" ]
	then
		dodir /usr/src
		cd ${S}
		echo ">>> Copying sources..."
		cp -ax ${WORKDIR}/* ${D}/usr/src
	elif [ "$PN" = "linux-headers" ]
	then
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
    if [ "$PN" = "linux-extras" ] || [ "$PN" = "linux-headers" ]
	then
		return
	fi
	rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${KV} ${ROOT}/usr/src/linux
    
    #copy over our .config if one isn't already present
    cd ${ROOT}/usr/src/linux-${KV}
    if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
    then
		cp -a .config.eg .config
    fi
}
