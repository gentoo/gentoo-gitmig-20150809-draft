# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.1_pre8.ebuild,v 1.1 2001/01/19 23:35:15 drobbins Exp $

S=${WORKDIR}/linux
KV=2.4.1-pre8
if [ "$PN" = "linux" ]
then
	DESCRIPTION="Linux kernel, including modules, binary tools, libraries and includes"
else
	DESCRIPTION="Kernel source package, including full sources, binary tools and libraries"
fi
SRC_URI="
http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0.tar.bz2
http://www.kernel.org/pub/linux/kernel/testing/patch-${KV}.bz2
http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.4.tar.gz
http://www.netroedge.com/~lm78/archive/i2c-2.5.4.tar.gz
http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.1.2-patch.tar.gz
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-0.5.10a.tar.bz2"
#LVM is now integrated into the kernel

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/
	  http://www.alsa-project.org"

src_unpack() {
    cd ${WORKDIR}
    unpack linux-2.4.0.tar.bz2
    cd ${S}
    echo "Applying ${KV} patch..."
    bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
    mkdir extras
	cd ${S}/extras
	
	echo "Unpacking ALSA drivers..."
	unpack alsa-driver-0.5.10a.tar.bz2

#lm_sensors buggy mkpatch.pl in 2.5.4!
#	for x in i2c
#	do
#		echo "Unpacking and applying $x patch..."
#		cd ${S}/extras
#		unpack ${x}-2.5.4.tar.gz
#		cd ${x}-2.5.4
#		mkpatch/mkpatch.pl . ${S} > ${S}/${x}-patch
#		cd ${S}
#		patch -p1 < ${x}-patch
#	done

#i#	echo "Preparing for compilation..."
#	cd ${S}
	#this is the configuration for the bootdisk/cd
#	cp ${FILESDIR}/${PV}/config .config
#	cp ${FILESDIR}/${PV}/autoconf.h include/linux/autoconf.h
#	try make include/linux/version.h
	
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root.root linux
}

src_compile() {

	cd ${S}
 #   try make symlinks
 #   try make dep

#    cd ${S}/lm_sensors-2.5.4
#    try make


    if [ "$PN" = "linux" ]
    then
		cd ${S}
		try make bzImage
		try make modules

#		figure out where LVM tools are installed
#		cd ${S}/extras/LVM/0.9
#		try ./configure --prefix=/
#		try make

		cd ${S}/extras/alsa-driver-0.5.10a
		try ./configure --with-kernel=${S} --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
		try make
    fi
}

src_install() {

#	should all be in reiserfs-utils package
#	cd ${S}/fs/reiserfs/utils
#	dodir /usr/man/man8 /sbin
#	try make install SBIN=${D}/sbin MANDIR=${D}/usr/man/man8

#	figure out where these come from now
#	cd ${S}/extras/LVM/0.9
#	make install prefix=${D} MAN8DIR=${D}/usr/man/man8 LIBDIR=${D}/lib

	dodir /usr/src

	if [ "$PN" = "linux" ]
	then

		dodir /usr/src/linux-${KV}
		cd ${D}/usr/src
		ln -sf linux-${KV} linux
		ln -sf linux-${KV} linux-2.4

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
		# Do we have a bug in modutils ?
		# Meanwhile we use this quick fix (achim)
		dodir /lib/modules/${KV}
		dodir /lib/modules/`uname -r`
		dodir ${D}/lib/modules/${KV}
		try make INSTALL_MOD_PATH=${D} modules_install

		#install ALSA modules
		cd ${S}/extras/alsa-driver-0.5.10a
		dodir /lib/modules/${KV}/misc
		cp modules/*.o ${D}/lib/modules/${KV}/misc
		into /usr
		dosbin snddevices
		dodir /usr/include/linux
		insinto /usr/src/linux-${KV}/include/linux
		cd include
		doins asound.h asoundid.h asequencer.h ainstr_*.h

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

pkg_postinst() {
    if [  "${ROOT}" = "/" ]
    then
	if [ "${PN}" = "linux" ] ; then
	    echo "Creating sounddevices..."
	    /usr/sbin/snddevices
		#needs to get fixed for devfs
		fi
    fi
}








