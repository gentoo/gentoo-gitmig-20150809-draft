# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.11.0-r1.ebuild,v 1.7 2008/05/09 22:50:51 tupone Exp $

inherit eutils autotools

DESCRIPTION="Cal3D is a skeletal based character animation library"
HOMEPAGE="http://home.gna.org/cal3d"
SRC_URI="http://download.gna.org/cal3d/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~x86-fbsd"
IUSE="16bit-indices debug doc"

DEPEND="doc? (
		app-doc/doxygen
		app-text/docbook-sgml-utils
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	if use doc; then
		sed -i \
			-e "s:db2html:docbook2html:g" \
			configure.in \
			docs/Makefile.am \
			|| die "sed for doc failed"
		eautoreconf
	fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable 16bit-indices) \
		|| die
	emake || die
	if use doc; then
		cd docs
		emake doc-api || die "Failed making doc-api"
		emake doc-guide || die "Failed making doc-guide"
		mkdir -p html/{guide,api}
		mv *.{html,gif} html/guide/
		mv api/html/* html/api/
	fi
}

src_install() {
	dodoc AUTHORS ChangeLog README TODO
	einstall || die
	use doc && dohtml -r docs/html/*
}
