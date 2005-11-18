# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pympd/pympd-0.05.2.ebuild,v 1.1 2005/11/18 00:08:34 ticho Exp $

inherit eutils python

DESCRIPTION="a Rhythmbox-like PyGTK+ client for Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/pympd"
SRC_URI="http://pympd.sourceforge.net/files/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="gnome"
RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2
	gnome? ( dev-python/gnome-python-extras )"

DOCS="README"

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install

	use gnome || cd ${D} && find -iname trayicon.* | xargs rm

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps

	cd ${S}
	newins src/glade/pixmaps/icon.png pympd.png
	make_desktop_entry "pympd" "pympd" "pympd.png" "Audio"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/pympd
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
