# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libident/libident-0.22.ebuild,v 1.1 2003/05/13 14:30:17 twp Exp $

DESCRIPTION="A small library to interface to the Ident protocol server"
HOMEPAGE="ftp://ftp.lysator.liu.se/pub/ident/libs"
SRC_URI="ftp://ftp.lysator.liu.se/pub/ident/libs/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS} -DHAVE_ANSIHEADERS" all || die
}

src_install() {
	dodoc README
	insinto /usr/include
	doins ident.h
	dolib.a libident.a
	doman ident.3
}
