# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnofract4d/gnofract4d-3.7.ebuild,v 1.1 2008/01/13 14:54:44 drac Exp $

inherit distutils fdo-mime multilib python

DESCRIPTION="a program for drawing beautiful mathematically-based images known as fractals."
HOMEPAGE="http://gnofract4d.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	media-libs/libpng
	media-libs/jpeg
	dev-python/pygtk
	gnome-base/gconf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/fract*
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
