# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfakekey/libfakekey-0.1.ebuild,v 1.1 2006/06/04 20:10:44 yvasilev Exp $

DESCRIPTION="Helper library for the x11-misc/matchbox-keyboard package."
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="debug doc"

RDEPEND="|| (	x11-libs/libXtst
		virtual/x11 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	# --with/without-x is ignored by configure script and X is used.
	econf	--with-x \
		$(use_enable debug) \
		$(use_enable doc doxygen-docs) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS Changelog INSTALL NEWS README
	use doc && dohtml doc/html/*
}
