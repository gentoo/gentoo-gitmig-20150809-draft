# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gtg/gtg-0.2.4.ebuild,v 1.1 2010/04/19 04:25:35 steev Exp $

inherit fdo-mime gnome2-utils distutils

DESCRIPTION="GTG is a personal organizer for the GNOME desktop environment."
HOMEPAGE="http://gtg.fritalk.com/"
SRC_URI="http://launchpad.net/${PN}/${PV:0:3}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/pycairo
	dev-python/pygobject
	dev-python/configobj
	dev-python/pyxdg
	dev-python/dbus-python"
DEPEND="${RDEPEND}"

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
