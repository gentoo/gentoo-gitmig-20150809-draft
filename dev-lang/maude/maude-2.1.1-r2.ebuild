# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/maude/maude-2.1.1-r2.ebuild,v 1.1 2004/10/11 06:44:25 phosphan Exp $

inherit eutils

DESCRIPTION="Maude - A high-level specification language"
HOMEPAGE="http://maude.cs.uiuc.edu/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${PN}-full-doc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="doc"

RDEPEND="virtual/libc
	dev-libs/buddy
	dev-libs/libtecla
	>=dev-libs/gmp-4.1.3
	>=sys-devel/gcc-3.4.3"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.4.patch
}

src_compile() {
	# econf/emake fails with a "file not found" error.
	./configure --bindir=/usr/bin --datadir=/usr/share/${PN} || die
	make || die
}

src_install() {
	make install DESTDIR=${D}
	dodoc AUTHORS ChangeLog NEWS README

	# Sets the full maude library path.
	insinto /etc/env.d
	doins ${FILESDIR}/23maude

	cd ${WORKDIR}/${PN}-full-doc-${PV}

	# Full maude library
	insinto /usr/share/${PN}
	doins full-maude.maude

	insinto /usr/share/doc/${P}/pdf
	doins maude-manual.pdf maude-primer.pdf
	insinto /usr/share/doc/${P}/ps
	doins maude-manual.ps

	if use doc; then
		insinto /usr/share/${PN}/examples
		doins maude-examples/*
		insinto /usr/share/${PN}/primer-examples
		doins examples/*
	fi
}

src_test() {
	pwd
	make check || die
}
