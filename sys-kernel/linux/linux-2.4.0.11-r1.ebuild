# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.4.0.11-r1.ebuild,v 1.2 2001/01/25 18:54:07 drobbins Exp $

S=${WORKDIR}/linux
KV=2.4.0-ac11
if [ "$PN" = "linux" ]
then
	DESCRIPTION="Linux kernel, including modules, binary tools, libraries and includes"
else
	DESCRIPTION="Kernel source package, including full sources, binary tools and libraries"
fi
SRC_URI="
http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0.tar.bz2
http://www.kernel.org/pub/linux/kernel/people/alan/2.4/patch-${KV}.bz2
http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.5.tar.gz 
http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.1.2-patch.tar.gz
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-0.5.10a.tar.bz2
ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_0.9.1_beta2.tar.gz"

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
	
	cd ${S}/extras
	echo "Unpacking LVM..."
 	unpack lvm_0.9.1_beta2.tar.gz   
	#patch does not appear necessary for this kernel

	echo "Unpacking ALSA drivers..."
	cd ${S}/extras
	unpack alsa-driver-0.5.10a.tar.bz2

	echo "Unpacking and applying lm_sensors patch..."
	cd ${S}/extras
	unpack lm_sensors-2.5.5.tar.gz
	cd lm_sensors-2.5.5
	mkpatch/mkpatch.pl . ${S} > ${S}/lm_sensors-patch
	cd ${S}
	patch -p1 < lm_sensors-patch   

	echo "Preparing for compilation..."
	cd ${S}
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper
	#this is the configuration for the default kernel
	#annoying but true -- we need to do this for linux-sources as well
	#so that autoconf.h exists and other packages compile
	cp ${FILESDIR}/${PV}/config .config
	cp ${FILESDIR}/${PV}/autoconf.h include/linux/autoconf.h
	try make include/linux/version.h

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root.root linux
}

src_compile() {
	#LVM tools are included even in the linux-sources package
	cd ${S}/extras/LVM/0.9.1_beta2
	try ./configure --prefix=/ --mandir=/usr/man
	try make

	cd ${S}
	try make symlinks
	try make dep
	
	#if we're just linux-sources, then we're done with all compilation stuff
	if [ "$PN" != "linux" ]
	then
		return
	fi

	cd ${S}/lm_sensors-2.5.5
	try make

	cd ${S}
	try make bzImage
	try make modules

	cd ${S}/extras/alsa-driver-0.5.10a
	try ./configure --with-kernel=${S} --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
	try make
}

src_install() {


	#clean up object files and original executables to reduce size of linux-sources
	try make clean
	dodir /usr/lib
	#no need for a static library in /lib
	mv ${D}/lib/liblvm*.a ${D}/usr/lib

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








