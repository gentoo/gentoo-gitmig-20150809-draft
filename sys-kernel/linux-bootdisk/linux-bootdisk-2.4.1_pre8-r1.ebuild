# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-bootdisk/linux-bootdisk-2.4.1_pre8-r1.ebuild,v 1.1 2001/01/21 22:07:10 achim Exp $

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
http://www.kernel.org/pub/linux/kernel/testing/patch-${KV}.bz2"

HOMEPAGE="http://www.kernel.org/"

src_unpack() {
    cd ${WORKDIR}
    unpack linux-2.4.0.tar.bz2
    cd ${S}
    echo "Applying ${KV} patch..."
    bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
    echo "Preparing for compilation..."
    cd ${S}
    #this is the configuration for the default kernel
    cp ${FILESDIR}/${PV}/config .config
    cp ${FILESDIR}/${PV}/autoconf.h include/linux/autoconf.h
    try make include/linux/version.h

    #fix silly permissions in tarball
    cd ${WORKDIR}
    chown -R root.root linux
}

src_compile() {

	cd ${S}
	try make symlinks
	try make dep
	try make bzImage
	try make modules

}

src_install() {

	dodir /usr/src

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

}





