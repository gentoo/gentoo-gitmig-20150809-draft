# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonata/sonata-0.9.ebuild,v 1.2 2006/12/04 00:26:45 ticho Exp $

inherit distutils

DESCRIPTION="A lightweight music player for MPD, written in Python."
HOMEPAGE="http://sonata.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="gnome"

RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2.6
	gnome? ( dev-python/gnome-python-extras )"

pkg_setup() {
	if ! built_with_use '=gtk+-2*' jpeg; then
		echo
		ewarn "If you want album cover art displayed in Sonata,"
		ewarn "you must build gtk+-2.x with \"jpeg\" USE flag."
		echo
		ebeep 3
	fi
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dodoc COPYING CHANGELOG README TODO TRANSLATORS
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
