# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-bootdisk/linux-bootdisk-2.4.1_pre8-r1.ebuild,v 1.2 2001/01/22 05:16:24 achim Exp $

S=${WORKDIR}/linux
KV=2.4.1-pre8
DESCRIPTION="Boot-CD Kernel with LVM utilities"
SRC_URI="
http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0.tar.bz2
http://www.kernel.org/pub/linux/kernel/testing/patch-${KV}.bz2
ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_0.9.1_beta2.tar.gz"

HOMEPAGE="http://www.kernel.org/
	  http://www.sistina.com/lvm/"

src_unpack() {
    cd ${WORKDIR}
    unpack linux-2.4.0.tar.bz2
    cd ${S}
    echo "Applying ${KV} patch..."
    bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1

    mkdir extras
    cd extras
    echo "Unpacking LVM..."
    unpack lvm_0.9.1_beta2.tar.gz   
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

	cd ${S}/extras/LVM/0.9.1_beta2
	try ./configure --prefix=/ --mandir=/usr/man
	try make

	cd ${S}
	try make symlinks
	try make dep
	try make bzImage
	try make modules

}

src_install() {


	cd ${S}/extras/LVM/0.9.1_beta2
	try make install prefix=${D} MAN8DIR=${D}/usr/man/man8 LIBDIR=${D}/lib
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





