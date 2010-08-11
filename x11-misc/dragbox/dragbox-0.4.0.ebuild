# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dragbox/dragbox-0.4.0.ebuild,v 1.1 2010/08/11 13:41:36 hwoarang Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python

DESCRIPTION="GTK tool for connecting the commandline with the desktop environment"
HOMEPAGE="http://kaizer.se/wiki/dragbox/"
SRC_URI="http://kaizer.se/publicfiles/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk
	gnome-base/libglade
	dev-python/gnome-vfs-python
	dev-python/libgnome-python
	dev-python/gconf-python
	sys-apps/dbus
	x11-libs/gtk+"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/Dragbox
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/Dragbox
}
