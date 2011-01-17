# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/apvlv/apvlv-0.1.0.ebuild,v 1.1 2011/01/17 23:47:21 radhermit Exp $

EAPI=3

inherit eutils cmake-utils

MY_P="${P}-Source"
DESCRIPTION="Alf's PDF Viewer Like Vim"
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI="http://apvlv.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug djvu"

RDEPEND=">=x11-libs/gtk+-2.10.4:2
	>=app-text/poppler-0.12.3-r3[cairo]
	djvu? ( app-text/djvu )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# bug #349979
	has_version ">=app-text/poppler-0.15.0" && epatch "${FILESDIR}"/${P}-poppler-0.16.patch

	# Remove prefixes so it works with the cmake-utils eclass
	sed -i -e "s:APVLV_::" src/CMakeLists.txt
}

src_configure() {
	mycmakeargs=(
		-DSYSCONFDIR=/etc/${PN}
		-DDOCDIR=/usr/share/doc/${PF}
		-DMANDIR=/usr/share/man
		-DWITH_UMD=OFF
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_with djvu)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS NEWS README THANKS TODO
	newicon icons/pdf.png ${PN}.png
	make_desktop_entry ${PN} "Alf's PDF Viewer Like Vim" ${PN} "Office;Viewer"
}
