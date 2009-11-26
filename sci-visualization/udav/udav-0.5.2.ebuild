# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/udav/udav-0.5.2.ebuild,v 1.1 2009/11/26 19:51:43 bicatali Exp $

EAPI=2
inherit qt4 fdo-mime flag-o-matic

DESCRIPTION="Universal Data Array Visualization"
HOMEPAGE="http://udav.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
RDEPEND="sci-libs/mathgl[qt4,hdf5]"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.1-pro.patch
}

src_compile() {
	append-flags -DH5_USE_16_API
	eqmake4
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	make_desktop_entry ${PN}
	insinto /usr/share/icons/hicolor/48x48/apps
	doins src/${PN}.png
	dosym /usr/share/icons/hicolor/48x48/apps/${PN}.png \
		/usr/share/pixmaps/${PN}.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
