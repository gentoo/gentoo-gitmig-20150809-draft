# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-UP-2.4.0/linux-sources-2.4.0_rc10.ebuild,v 1.1 2000/11/10 19:44:12 drobbins Exp $

A="linux-2.4.0-test8.tar.bz2 linux-2.4.0-test9-reiserfs-3.6.18-patch.gz
	patch-2.4.0-test9.bz2 patch-2.4.0-test10.bz2
	i2c-2.5.4.tar.gz lm_sensors-2.5.4.tar.gz jfs-0.0.17-patch.tar.gz
	alsa-driver-0.5.9d.tar.bz2 NVIDIA_kernel-0.9-5.tar.gz"

S=/usr/src/linux
DESCRIPTION="Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test8.tar.bz2
		http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test9.bz2
		http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test10.bz2
	 	http://devlinux.com/pub/namesys/2.4-beta/linux-2.4.0-test9-reiserfs-3.6.18-patch.gz
  	 	http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.4.tar.gz
	 	http://www.netroedge.com/~lm78/archive/i2c-2.5.4.tar.gz
	 	http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.0.17-patch.tar.gz
		ftp://ftp.alsa-project.org/pub/driver/alsa-driver-0.5.9d.tar.bz2
		ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/"

	
src_compile() {
    cd ${S}
    unset CFLAGS
    unset CXXFLAGS
    try make dep
    try make bzImage
    try make modules
    cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.2
    try make
	cd ${S}/fs/jfs/utils
	try make
}

src_unpack() {
    cd /usr/src 
	local x
	for x in linux linux-2.4.0-test10 
	do
		if [ -e $x ]
		then
			echo "linux kernel source directory ($x) already exists.  Please remove or backup first."
			exit 1
		fi
	done
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
	unpack jfs-0.0.17-patch.tar.gz
	cd ${S}
	patch -p1 < extras/jfs/jfs-common-v0.0.17-patch 
	patch -p1 < extras/jfs/jfs-2.4.0-test10-v0.0.17-patch 

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
	echo
}










