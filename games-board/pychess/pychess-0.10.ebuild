# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pychess/pychess-0.10.ebuild,v 1.7 2012/04/13 19:16:05 ulm Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit python games distutils

DESCRIPTION="A chess client for Gnome"
HOMEPAGE="http://pychess.googlepages.com/home"
SRC_URI="http://pychess.googlecode.com/files/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gstreamer"

DEPEND="dev-python/librsvg-python
	dev-python/pycairo
	dev-python/pygobject:2
	dev-python/pygtk
	dev-python/pygtksourceview
	dev-python/pysqlite
	gstreamer? ( dev-python/gst-python )
	dev-python/gconf-python
	x11-themes/gnome-icon-theme"

S=${WORKDIR}/${P/_/}

src_prepare() {
	python_convert_shebangs -r 2 .
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_install() {
	distutils_src_install --install-scripts="${GAMES_BINDIR}"
	dodoc AUTHORS README
	prepgamesdirs
}
