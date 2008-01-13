# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonata/sonata-1.2.2.ebuild,v 1.3 2008/01/13 15:06:51 drac Exp $

inherit distutils fdo-mime multilib python

DESCRIPTION="A lightweight music player for MPD, written in Python."
HOMEPAGE="http://sonata.berlios.de"
SRC_URI="http://download2.berlios.de/${PN}/${P}.tar.bz2
	http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 ~x86"
IUSE="taglib lyrics dbus"

RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2.10
	taglib? ( >=dev-python/tagpy-0.91 )
	dbus? ( dev-python/dbus-python )
	lyrics? ( dev-python/soappy )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use '=x11-libs/gtk+-2*' jpeg; then
		ewarn "If you want album cover art displayed in Sonata,"
		ewarn "you must build gtk+-2.x with \"jpeg\" USE flag."
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	python_mod_cleanup
	fdo-mime_desktop_database_update
}
