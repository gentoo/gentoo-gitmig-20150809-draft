# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libedit/libedit-20040610.ebuild,v 1.5 2004/09/08 03:33:09 vapier Exp $

inherit eutils

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libedit/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="sys-libs/ncurses
	virtual/libc"

S=${WORKDIR}/netbsd-cvs

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ${WORKDIR}/glibc-*/*.c .
	epatch ${FILESDIR}/20031222-debian-to-gentoo.patch
}

src_compile() {
	emake -j1 || die
}

src_install() {
	dolib.so libedit.so || die
	dolib.a libedit.a || die
	doman *.[35]
}
