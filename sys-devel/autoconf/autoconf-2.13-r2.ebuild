# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.13-r2.ebuild,v 1.1 2001/02/07 16:05:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/autoconf/${A}
	 ftp://prep.ai.mit.edu/gnu/autoconf/${A}"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"

DEPEND="sys-devel/perl
        >=sys-devel/m4-1.4o-r2"

src_compile() {

    try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST}
    try make ${MAKEOPTS}

}

src_install() {

    try make prefix=${D}/usr infodir=${D}/usr/share/info install
    dodoc COPYING AUTHORS ChangeLog.* NEWS README TODO

}


