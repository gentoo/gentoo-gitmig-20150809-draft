# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/elem/elem-1.0.1.ebuild,v 1.6 2004/07/01 11:50:56 eradicator Exp $

DESCRIPTION="periodic table of the elements"
HOMEPAGE="http://elem.sourceforge.net/"
SRC_URI="mirror://sourceforge/elem/${PN}-src-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

S=${WORKDIR}/${PN}

RDEPEND="virtual/x11
	virtual/libc
	x11-libs/xforms"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack () {
	unpack ${A}
	cd ${S}
	einfo "Modifying Makefile..."
	sed -i -e 's:^LIBS.*:\0 -lXpm:' Makefile
}

src_compile () {
	emake all || die "Build failed."
}

src_install () {
	into /usr
	dobin elem elem-de elem-en
	dohtml -r doc/*
}

