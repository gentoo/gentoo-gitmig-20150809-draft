# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pympd/pympd-0.04.ebuild,v 1.2 2005/11/03 07:46:53 swegener Exp $

inherit distutils

DESCRIPTION="a Rhythmbox-like PyGTK+ client for Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/pympd"
SRC_URI="http://pympd.sourceforge.net/files/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="gnome lirc"
RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2
	gnome? ( dev-python/gnome-python-extras )
	lirc? (  dev-python/python-xlib
			dev-python/pyosd )"

DOCS="README"

src_install() {
	distutils_src_install

	use gnome || cd ${D} && find -iname trayicon.* | xargs rm
	use lirc  || cd ${D} && find -iname MpdLIRCServer.* | xargs rm
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/pympd
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
