# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wefts/wefts-0.99c.ebuild,v 1.1 2004/12/30 21:12:11 chriswhite Exp $

inherit eutils

MY_P="lib${P}"

DESCRIPTION="A C++ high-level yet efficent multithreading library, portable across pthread-enabled platforms."

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://wefts.sourceforge.net/"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="doc debug"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-errno.patch
}

src_compile() {
	econf \
	$(use_enable doc) \
	$(use_enable debug) \
	|| die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	if use doc; then
		dohtml -r ${S}/doc/html/*
	fi
}

