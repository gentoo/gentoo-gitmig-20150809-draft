# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.10o.ebuild,v 1.3 2000/10/29 20:37:00 achim Exp $

P="util-linux-2.10o"      
A="${P}.tar.bz2" 

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/util-linux/${P}.tar.bz2"

src_compile() {                           
	try ./configure
	try make
}

src_unpack() {
    unpack ${P}.tar.bz2 
    cd ${S}
    gzip -dc ../../../linux-UP-2.2.17-r3/work/linux/Documentation/crypto/util-linux-2.10o* | patch -p1
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


