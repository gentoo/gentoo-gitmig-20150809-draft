# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/udav/udav-0.7.1.2.ebuild,v 1.1 2011/06/04 20:18:08 grozin Exp $

EAPI=2
inherit qt4 fdo-mime

DESCRIPTION="Universal Data Array Visualization"
HOMEPAGE="http://udav.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RDEPEND=">=sci-libs/mathgl-1.10.2[qt4,hdf5]"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pro.patch
}

src_compile() {
	eqmake4
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	dosym /usr/share/icons/hicolor/64x64/apps/${PN}.png \
		/usr/share/pixmaps/${PN}.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
