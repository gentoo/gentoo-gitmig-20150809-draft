# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libedit/libedit-20031222.ebuild,v 1.1 2003/12/22 20:28:47 vapier Exp $

inherit eutils

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libedit/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses
	virtual/glibc"

S=${WORKDIR}/netbsd-cvs

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ${WORKDIR}/glibc-*/*.c .
	epatch ${FILESDIR}/${PV}-debian-to-gentoo.patch
}

src_compile() {
	emake -j1 || die
}

src_install() {
	dolib.so libedit.so
	dolib.a libedit.a
	doman *.[35]
}
