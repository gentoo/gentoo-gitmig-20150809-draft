# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pympd/pympd-0.06.ebuild,v 1.5 2006/12/04 00:49:38 ticho Exp $

inherit eutils python

DESCRIPTION="a Rhythmbox-like PyGTK+ client for Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/pympd"
SRC_URI="http://pympd.sourceforge.net/files/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
SLOT="0"

IUSE="gnome"
RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2.6
	gnome? ( dev-python/gnome-python-extras )"

DOCS="README"

pkg_setup() {
	if ! built_with_use '=gtk+-2*' jpeg; then
		echo
		ewarn "If you want album cover art displayed in pympd,"
		ewarn "you must build gtk+-2.x with \"jpeg\" USE flag."
		echo
		ebeep 3
	fi
}

src_compile() {
	make PREFIX="/usr" DESTDIR="${D}"
}

src_install() {
	make PREFIX="/usr" DESTDIR="${D}" install

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

	echo
	ewarn
	ewarn "You need to remove the .pympd directory from your home directory, as new"
	ewarn "version uses different settings format"
	ewarn
	echo
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
