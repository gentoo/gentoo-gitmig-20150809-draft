# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/grep/grep-2.4.2-r1.ebuild,v 1.1 2001/01/25 18:00:26 achim Exp $

P=grep-2.4.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU regular expression matcher"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/grep/${A}
	 ftp://prep.ai.mit.edu/gnu/grep/${A}"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
DEPEND=">=sys-libs/glibc-2.1.3"
src_compile() {
	try ./configure --prefix=/usr --host=${CHOST} --disable-nls
	try make LDFLAGS=-static ${MAKEOPTS}
}

src_install() {
	cd ${S}/src
        dobin grep
        cd ${D}/usr/bin
        ln grep egrep
        ln grep fgrep
}



