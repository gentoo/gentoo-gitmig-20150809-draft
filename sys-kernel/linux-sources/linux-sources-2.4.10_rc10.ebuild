# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.10_rc10.ebuild,v 1.2 2000/11/20 02:38:56 drobbins Exp $

A="linux-2.4.0-test8.tar.bz2 linux-2.4.0-test9-reiserfs-3.6.18-patch.gz
	patch-2.4.0-test9.bz2 patch-2.4.0-test10.bz2
	i2c-2.5.4.tar.gz lm_sensors-2.5.4.tar.gz jfs-0.0.18-patch.tar.gz
	alsa-driver-0.5.9d.tar.bz2 NVIDIA_kernel-0.9-5.tar.gz"

S=${WORKDIR}/linux
DESCRIPTION="Linux kernel sources package.  Everything you need to build a kernel (no kernel included, just sources)"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test8.tar.bz2
		http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test9.bz2
		http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test10.bz2
	 	http://devlinux.com/pub/namesys/2.4-beta/linux-2.4.0-test9-reiserfs-3.6.18-patch.gz
  	 	http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.4.tar.gz
	 	http://www.netroedge.com/~lm78/archive/i2c-2.5.4.tar.gz
	 	http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.0.18-patch.tar.gz
		ftp://ftp.alsa-project.org/pub/driver/alsa-driver-0.5.9d.tar.bz2
		ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/"

	
src_compile() {
    cd ${S}
	make dep
	cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.2
    try make
	cd ${S}/fs/jfs/utils
	try make
}

src_unpack() {
    cd ${WORKDIR} 
	unpack linux-2.4.0-test8.tar.bz2
    cd ${S}
	echo "Applying test9 patch..."
    cat ${DISTDIR}/patch-2.4.0-test9.bz2 | bzip2 -d | patch -p1
	echo "Applying ReiserFS patch..."
    gzip -dc ${DISTDIR}/linux-2.4.0-test9-reiserfs-3.6.18-patch.gz | patch -p1
	echo "Applying test10 patch..."
	cat ${DISTDIR}/patch-2.4.0-test10.bz2 | bzip2 -d | patch -p1
    
	mkdir extras
	echo "Applying IBM JFS patch..."
	cd extras
	mkdir jfs
	cd jfs
	unpack jfs-0.0.18-patch.tar.gz
	cd ${S}
	patch -p1 < extras/jfs/jfs-common-v0.0.18-patch 
	patch -p1 < extras/jfs/jfs-2.4.0-test10-v0.0.18-patch 

	echo "Preparing for compilation..."
	try make include/linux/version.h
    try make symlinks
	cd ${S}; cd ..
	mv linux linux-2.4.0-test10
	ln -s linux-2.4.0-test10 linux
	cd ${S}/extras 
	echo "Unpacking ALSA drivers..."
	unpack alsa-driver-0.5.9d.tar.bz2
	echo "Unpacking NVidia drivers..."
	unpack NVIDIA_kernel-0.9-5.tar.gz
	for x in lm_sensors i2c
	do
		echo "Unpacking and applying $x patch..."
		cd ${S}/extras
		unpack ${x}-2.5.4.tar.gz
#		cd ${x}-2.5.4
#		mkpatch/mkpatch.pl . /usr/src/linux > /usr/src/linux/${x}-patch
#		cd ${S}
#		patch -p1 < ${x}-patch
	done
	
}

src_install() {                               
	cd ${S}/fs/reiserfs/utils
	dodir /usr/man/man8 /sbin
	try make install SBIN=${D}/sbin MANDIR=${D}/usr/man/man8

	cd ${S}/fs/jfs/utils
	cp output/* ${D}/sbin
	local x 
	for x in `find -iname *.1`
	do
		doman $x
	done
	for x in `find -iname *.8`
	do
		doman $x
	done
	dodir /usr/src/linux-${PV}
	cd ${S}
	mv linux ${D}/usr/src/linux-${PV}
	cd ${D}/usr/src
	ln -s linux-${PV} linux
	#remove workdir since our install was dirty and modified ${S}
	#this will cause an unpack to be done next time
	rm -rf ${WORKDIR}
}










