# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/mergetrees/mergetrees-0.9.3.ebuild,v 1.1 2001/06/05 15:33:15 aj Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A three-way directory merge tool"
SRC_URI="http://cvs.bofh.asn.au/mergetrees/${A}"
HOMEPAGE="http://cvs.bofh.asn.au/mergetrees/"

RDEPEND="virtual/glibc
	>=sys-devel/perl-5
	>=sys-apps/diffutils-2"

src_compile() {                           
   try ./configure --prefix=/usr/ --mandir=/usr/share/man --infodir=/usr/share/info
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    try make prefix=${D}/usr/ mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    dodoc AUTHORS COPYING Changelog NEWS README* TODO
}

