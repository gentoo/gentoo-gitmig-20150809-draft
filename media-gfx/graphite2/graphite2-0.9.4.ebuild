# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphite2/graphite2-0.9.4.ebuild,v 1.1 2011/07/26 19:02:19 scarabeus Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Library providing rendering capabilities for complex non-Roman writing systems"
HOMEPAGE="http://graphite.sil.org/"
SRC_URI="mirror://sourceforge/silgraphite/${PN}/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		dev-texlive/texlive-latex
	)
"

src_configure() {
	local mycmakeargs=(
		"-DVM_MACHINE_TYPE=direct"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && Icmake-utils_src_compile docs
}

src_install() {
	cmake-utils_src_install

	find "${ED}" -name '*.la' -exec rm -f {} +

	use doc && dodoc ${CMAKE_BUILD_DIR}/{manual.html,doxygen/latex/refman.pdf}
}
