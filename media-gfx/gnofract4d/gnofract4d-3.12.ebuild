# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnofract4d/gnofract4d-3.12.ebuild,v 1.3 2010/03/29 21:35:45 maekke Exp $

EAPI=2

PYTHON_DEPEND="2:2.6"

inherit distutils eutils fdo-mime

DESCRIPTION="a program for drawing beautiful mathematically-based images known as fractals."
HOMEPAGE="http://gnofract4d.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2:2
	media-libs/libpng
	media-libs/jpeg
	>=dev-python/pygtk-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/fract*
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/fract*
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
