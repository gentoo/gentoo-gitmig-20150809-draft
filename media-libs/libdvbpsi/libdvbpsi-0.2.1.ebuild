# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.2.1.ebuild,v 1.1 2011/09/20 17:50:21 aballier Exp $

IUSE="doc"

DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://download.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
# doxygen missing: ~ia64
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="doc? (
		>=app-doc/doxygen-1.2.16
		media-gfx/graphviz
	)"
RDEPEND=""

pkg_setup() {
	if use doc; then
		# Making the documentation requires that /usr/bin/dot from
		# media-libs/graphviz supports PNG output.
		# This is an automagic dependency :(, Bug #181147
		# Check that /usr/bin/dot supports png by calling it with
		# an unsupported format (-Txxx) to get a list of supported formats

		if /usr/bin/dot -Txxx 2>&1 | grep -q png ; then
			# dot supports png
			:
		else
			die "You need to recompile media-gfx/graphviz with png support."
		fi
	fi
}

src_compile() {
	econf --enable-release

	emake || die "emake failed"

	if use doc; then
		einfo "Attempting to build documentation"
		emake doc || die "Could not build documentation."
	else
		einfo "Documentation was not built"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die
	use doc && dohtml "${S}"/doc/doxygen/html/*
	dodoc AUTHORS INSTALL README NEWS
}
