# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.10q-r1.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/util-linux/${P}.tar.bz2"
DEPEND=">=sys-libs/ncurses-5.2-r2"


RDEPEND="$DEPEND
	 sys-devel/perl"

src_unpack() {

    unpack ${P}.tar.bz2
    cd ${S}
    cp MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2 -m486 -fomit-frame-pointer/${CFLAGS}/" \
        -e "s/CPU=.*/CPU=${CHOST%%-*}/" \
        -e "s/HAVE_PAM=no/HAVE_PAM=yes/" \
	-e "s/HAVE_SLN=no/HAVE_SLN=yes/" \
	-e "s/HAVE_TSORT=no/HAVE_TSORT=yes/" \
        -e "s:usr/man:usr/share/man:" \
        -e "s:usr/info:usr/share/info:" \
	MCONFIG.orig > MCONFIG.orig2

}

src_compile() {

	try ./configure
	try make ${MAKEOPTS} LDFLAGS=\"\"
}


src_install() {

	try make DESTDIR=${D} install

	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}


