# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/elem/elem-1.0.1.ebuild,v 1.3 2003/04/24 13:44:14 phosphan Exp $

DESCRIPTION="periodic table of the elements"
HOMEPAGE="http://elem.sourceforge.net/"
SRC_URI="mirror://sourceforge/elem/${PN}-src-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND="virtual/x11
	virtual/glibc
	x11-libs/xforms"

src_unpack () {
	unpack ${A}
	cd ${S}
	einfo "Modifying Makefile..."
	sed < Makefile -e 's:^LIBS.*:\0 -lXpm:' > Makefile.tmp && mv Makefile.tmp Makefile
}

src_compile () {
	emake all || die "Build failed."
}

src_install () {
	into /usr
	dobin elem elem-de elem-en
	dohtml -r doc/*
}

