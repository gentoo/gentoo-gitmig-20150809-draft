# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-bootdisk/linux-bootdisk-2.4.0_rc10-r7.ebuild,v 1.1 2001/01/08 10:07:29 achim Exp $

S=${WORKDIR}/linux
KV=2.4.0-test10
DESCRIPTION="Linux kernel, including modules, binary tools, libraries and includes"

SRC_URI="
http://www.kernel.org/pub/linux/kernel/v2.4/linux-${KV}.tar.bz2 
ftp://ftp.reiserfs.org/pub/2.4/linux-${KV}-reiserfs-3.6.22-patch.gz
ftp://ftp.sistina.com/pub/LVM/0.9/lvm_0.9.tar.gz"

HOMEPAGE="http://www.kernel.org/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/"
	


src_unpack() {

    cd ${WORKDIR} 
    unpack linux-${KV}.tar.bz2
    cd ${S}
    echo "Applying ReiserFS patch..."
    gzip -dc ${DISTDIR}/linux-${KV}-reiserfs-3.6.22-patch.gz | patch -p1

    cd ${S}
    echo "Applying reiser-nfs patch..."
    gzip -dc ${FILESDIR}/${PV}/linux-${KV}-reiserfs-3.6.22-nfs.diff.gz | patch -p1
    mkdir extras

    cd ${S}/extras
    echo "Applying LVM 0.9 patch..."
    unpack lvm_0.9.tar.gz
    cd LVM/0.9/PATCHES
    cat linux-2.4.0-test10-VFS-lock.patch | ( cd ${S}; patch -p1 -f)
    cat lvm-0.9-2.4.0-test10.patch | ( cd ${S}; patch -p1 -f)  

    echo "Preparing for compilation..."
    cd ${S}
    #this is the configuration for the bootdisk/cd
    cp ${FILESDIR}/${PV}/${PF}.config .config
    cp ${FILESDIR}/${PV}/${PF}.autoconf include/linux/autoconf.h
    try make include/linux/version.h
    #fix silly permissions in tarball
    cd ${WORKDIR}
    chown -R root.root linux 

}

src_compile() {

	cd ${S}
	try make symlinks
	try make dep

	#symlink tweak in place
	cd ${S}/fs/reiserfs/utils
        try make
        cd ${S}
	try make bzImage
	try make modules

	cd ${S}/extras/LVM/0.9
	try ./configure --prefix=/
	try make
	#untweak the symlink
	if [ -e ${T}/linuxlink ]
	then
		( cd /usr/src; rm linux; ln -s `cat ${T}/linuxlink` linux )
	fi
}
src_install() {                               
	cd ${S}/fs/reiserfs/utils
	dodir /usr/man/man8 /sbin
	try make install SBIN=${D}/sbin MANDIR=${D}/usr/man/man8

	cd ${S}/extras/LVM/0.9
	make install prefix=${D} MAN8DIR=${D}/usr/man/man8 LIBDIR=${D}/lib
	dodir /usr/src

	#grab compiled kernel
	dodir /boot/boot
	insinto /boot/boot
	cd ${S}
	doins arch/i386/boot/bzImage

	#grab modules
	try make INSTALL_MOD_PATH=${D} modules_install

	#fix symlink
	cd ${D}/lib/modules/${KV}
	rm build
}









