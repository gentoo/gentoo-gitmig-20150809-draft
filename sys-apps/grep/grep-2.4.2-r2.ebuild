# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.4.2-r2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU regular expression matcher"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/grep/${A}
	 ftp://prep.ai.mit.edu/gnu/grep/${A}"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"

RDEPEND="virtual/glibc"

src_compile() {
	try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {

        try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install

        dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO

}



