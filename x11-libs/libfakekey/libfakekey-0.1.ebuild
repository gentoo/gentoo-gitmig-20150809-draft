# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfakekey/libfakekey-0.1.ebuild,v 1.8 2009/12/14 04:58:28 yvasilev Exp $

DESCRIPTION="Helper library for the x11-misc/matchbox-keyboard package."
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="debug doc"

RDEPEND="x11-libs/libXtst"

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

	dodoc AUTHORS ChangeLog INSTALL NEWS README
	use doc && dohtml doc/html/*
}
