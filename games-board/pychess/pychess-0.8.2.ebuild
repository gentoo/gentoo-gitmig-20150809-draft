# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pychess/pychess-0.8.2.ebuild,v 1.1 2008/08/31 05:50:46 mr_bones_ Exp $

EAPI=1
inherit python games distutils

DESCRIPTION="A chess client for Gnome"
HOMEPAGE="http://pychess.googlepages.com/home"
SRC_URI="http://pychess.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer"

DEPEND="dev-python/pygtk
	dev-python/pygobject
	dev-python/pycairo
	dev-python/pysqlite:2
	gstreamer? ( dev-python/gst-python )
	dev-python/gnome-python-desktop
	x11-themes/gnome-icon-theme"

src_install() {
	python_version
	distutils_src_install --install-scripts="${GAMES_BINDIR}"
	dodoc AUTHORS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	distutils_pkg_postinst
}
