# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.10m-r1.ebuild,v 1.3 2000/09/15 20:09:24 drobbins Exp $

P="util-linux-2.10m"      
A="${P}.tar.bz2 
   ${P}-mount-compat.patch
   ${P}-mount-nfsv3.patch
   ${P}-mount-rpc.patch"

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/util-linux/${P}.tar.bz2
	 ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/${P}-mount-compat.patch
	 ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/${P}-mount-nfsv3.patch
	 ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/${P}-mount-rpc.patch"

src_compile() {                           
	try ./configure
	try make
}

src_unpack() {
    unpack ${P}.tar.bz2 
    cd ${S}
    patch -p1 < ${DISTDIR}/${P}-mount-compat.patch
    patch -p1 < ${DISTDIR}/${P}-mount-nfsv3.patch
    patch -p1 < ${DISTDIR}/${P}-mount-rpc.patch
    cp MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2 -m486 -fomit-frame-pointer/${CFLAGS}/" \
        -e "s/HAVE_PAM=no/HAVE_PAM=yes/" \
	-e "s/HAVE_SLN=no/HAVE_SLN=yes/" \
	-e "s/HAVE_TSORT=no/HAVE_TSORT=yes/" \
	-e "s/# HAVE_SLANG/HAVE_SLANG/" \
	-e "s/# SLANGFLAGS/SLANGSFLAGS/" \
	MCONFIG.orig > MCONFIG
}

src_install() {                               
	cd ${S}
	try make DESTDIR=${D} install
	cd ${S}
	dodoc licenses/* HISTORY 
	prepman
	prepinfo
	docinto examples
	dodoc example.files/*
}


