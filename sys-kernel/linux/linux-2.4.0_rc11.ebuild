# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.4.0_rc11.ebuild,v 1.3 2000/12/05 16:00:14 achim Exp $

S=${WORKDIR}/linux
KV=2.4.0-test11
if [ "$PN" = "linux" ]
then
	DESCRIPTION="Linux kernel, including modules, binary tools, libraries and includes"
else
	DESCRIPTION="Kernel source package, including full sources, binary tools and libraries"
fi
SRC_URI="
http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test11.bz2 
http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test10.bz2 
http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.0-test9.bz2 
http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test8.tar.bz2 
ftp://ftp.reiserfs.org/pub/2.4/linux-2.4.0-test10-reiserfs-3.6.19-patch.gz
http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.4.tar.gz 
http://www.netroedge.com/~lm78/archive/i2c-2.5.4.tar.gz 
http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.0.18-patch.tar.gz 
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-0.5.9d.tar.bz2 
ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz 
ftp://ftp.sistina.com/pub/LVM/0.9/lvm_0.9.tar.gz"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/
	  http://www.alsa-project.org
	  http://www.nvidia.com"
	
src_compile() {
   	#time to do the special symlink tweak
	if [ -e /usr/src/linux ]
	then
		readlink /usr/src/linux > ${T}/linuxlink
	fi
	rm /usr/src/linux
	( cd /usr/src; ln -s ${S} linux )
	#symlink tweak in place
	cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.2
    try make
	cd ${S}/fs/jfs/utils
	try make
	if [ "$PN" = "linux" ]
	then
		cd ${S}
		try make bzImage
		try make modules
		cd ${S}/extras/NVIDIA_kernel-0.9-5
		make NVdriver
		cd ${S}/extras/alsa-driver-0.5.9d
		try ./configure --with-kernel=${S} --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
		try make
	fi
	cd ${S}/extras/LVM/0.9
	try ./configure --prefix=/
	try make
	#untweak the symlink
	if [ -e ${T}/linuxlink ]
	then
		( cd /usr/src; rm linux; ln -s `cat ${T}/linuxlink` linux )
	else
		rm /usr/src/linux
	fi
}

src_unpack() {
	if [ -e /usr/src/linux ]
	then
		if [ ! -L /usr/src/linux ]
		then
			echo '!!!' /usr/src/linux is not a symbolic link.
			echo '!!!' For ${PF} to compile correctly, /usr/src/linux
			echo '!!!' needs to be temporarily modified to point to
			echo '!!!' a temporary build directory.  Please rename your
			echo '!!!' current directory and restart this build process.
			exit 1
		fi
	fi
	cd ${WORKDIR} 
	unpack linux-2.4.0-test8.tar.bz2
   	cd ${S}
	echo "Applying test9 patch..."
    cat ${DISTDIR}/patch-2.4.0-test9.bz2 | bzip2 -d | patch -p1
	echo "Applying test10 patch..."
	cat ${DISTDIR}/patch-2.4.0-test10.bz2 | bzip2 -d | patch -p1
    echo "Applying ReiserFS patch..."
    gzip -dc ${DISTDIR}/linux-2.4.0-test10-reiserfs-3.6.19-patch.gz | patch -p1
	cd ${S}
	mkdir extras
	echo "Applying IBM JFS patch..."
	cd extras
	mkdir jfs
	cd jfs
	unpack jfs-0.0.18-patch.tar.gz
	cd ${S}
	patch -p1 < extras/jfs/jfs-common-v0.0.18-patch 
	patch -p1 < extras/jfs/jfs-2.4.0-test10-v0.0.18-patch 

	cd ${S}/extras 
	echo "Unpacking ALSA drivers..."
	unpack alsa-driver-0.5.9d.tar.bz2
	echo "Unpacking NVidia drivers..."
	unpack NVIDIA_kernel-0.9-5.tar.gz
	cd NVIDIA_kernel-0.9-5
	# this is a little fix to make the NVidia drivers compile right with test10
	mv nv.c nv.c.orig
	echo '#define mem_map_inc_count(p) atomic_inc(&(p->count))' > nv.c
	echo '#define mem_map_dec_count(p) atomic_dec(&(p->count))' >> nv.c
	cat nv.c.orig >> nv.c
	cd ${S}/extras
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
	cd ${S}/extras
	echo "Applying LVM 0.9 patch..."
#	one patch will fail, this is OK (it was applied earlier probably by the JFS patch)
#	we pass the -f argument to patch to get around and already-applied patch
	unpack lvm_0.9.tar.gz
	cd LVM/0.9/PATCHES
	cat linux-2.4.0-test10-VFS-lock.patch | ( cd ${S}; patch -p1 -f)
	cat lvm-0.9-2.4.0-test10.patch | ( cd ${S}; patch -p1 -f)
	echo "Applying test11 patch..."
	cd ${S}
	cat ${DISTDIR}/patch-2.4.0-test11.bz2 | bzip2 -d | patch -p1
	echo "Preparing for compilation..."
	#this is the configuration for the bootdisk/cd
	cp ${FILESDIR}/${PV}/${P}.config .config
	cp ${FILESDIR}/${PV}/${P}.autoconf include/linux/autoconf.h
	try make include/linux/version.h
    try make symlinks
	try make dep
	cd ${S}
	#fix silly permissions in tarball
	chown -R root.root *
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
	cd ${S}/extras/LVM/0.9
	make install prefix=${D} MAN8DIR=${D}/usr/man/man8 LIBDIR=${D}/lib
	dodir /usr/src
	if [ "$PN" = "linux" ]
	then
		dodir /usr/src/linux-${KV}
		cd ${D}/usr/src
		ln -sf linux-${KV} linux
		#grab includes and documentation only
		dodir /usr/src/linux-${KV}/include/linux
		dodir /usr/src/linux-${KV}/include/asm-i386
		cp -ax ${S}/include ${D}/usr/src/linux-${KV}
		cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
		dodir /usr/include
		dosym /usr/src/linux/include/linux /usr/include/linux
		dosym /usr/src/linux/include/asm-i386 /usr/include/asm
		#grab compiled kernel
		dodir /boot/boot
		insinto /boot/boot
		cd ${S}
		doins arch/i386/boot/bzImage
		#grab modules
		try make INSTALL_MOD_PATH=${D} modules_install
		#install ALSA modules
		cd ${S}/extras/alsa-driver-0.5.9d
		dodir /lib/modules/${KV}/misc
		cp modules/*.o ${D}/lib/modules/${KV}/misc
		dodir /usr/include/linux
		insinto /usr/include/linux
		cd include
		doins asound.h asoundid.h asequencer.h ainstr_*.h
		#install nvidia driver
		cd ${S}/extras/NVIDIA_kernel-0.9-5
		insinto /lib/modules/${KV}/video
		doins NVdriver
		#fix symlink
		cd ${D}/lib/modules/${KV}
		rm build
		ln -sf /usr/src/linux-${KV} build
	else
		#grab all the sources
		cd ${WORKDIR}
		mv linux ${D}/usr/src/linux-${KV}
		cd ${D}/usr/src
		ln -sf linux-${KV} linux
		#remove workdir since our install was dirty and modified ${S}
		#this will cause an unpack to be done next time
		rm -rf ${WORKDIR}
	fi
}










