# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/elem/elem-1.0.3-r1.ebuild,v 1.2 2004/11/20 18:10:53 config Exp $

inherit toolchain-funcs

DESCRIPTION="periodic table of the elements"
HOMEPAGE="http://elem.sourceforge.net/"
SRC_URI="mirror://sourceforge/elem/${PN}-src-${PV}-Linux.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	virtual/libc
	x11-libs/xforms"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's:\(^LIBS = .*\):\1 -lXpm:' -i Makefile || die "sed failed"
}

src_compile () {
	emake COMPILER="$(tc-getCC)" FLAGS="${CFLAGS}" all || die "Build failed."
}

src_install () {
	into /usr
	dobin elem elem-de elem-en
	dohtml -r doc/*
}

