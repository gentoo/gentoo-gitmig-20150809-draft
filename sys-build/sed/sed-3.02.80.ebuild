# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/sed/sed-3.02.80.ebuild,v 1.1 2001/01/25 18:00:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Super-useful stream editor"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/sed/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST} --disable-nls
	try make ${MAKEOPTS} LDFLAGS=-static
}

src_install() {
	into /usr
	dobin sed/sed
}

