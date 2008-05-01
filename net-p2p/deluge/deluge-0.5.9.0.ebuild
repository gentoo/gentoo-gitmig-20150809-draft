# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-0.5.9.0.ebuild,v 1.1 2008/05/01 09:58:56 armin76 Exp $

inherit eutils distutils flag-o-matic

DESCRIPTION="BitTorrent client in Python and PyGTK."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://download.deluge-torrent.org/source/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="libnotify"

S="${WORKDIR}"/${PN}-torrent-${PV}

DEPEND=">=dev-lang/python-2.3
	dev-libs/boost"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2
	dev-python/pyxdg
	dev-python/dbus-python
	gnome-base/librsvg
	libnotify? ( dev-python/notify-python )"

pkg_setup() {
	if ! built_with_use --missing true "dev-libs/boost" threads; then
		eerror "dev-libs/boost has to be built with threads USE-flag."
		die "Missing threads USE-flag for dev-libs/boost"
	fi

	filter-ldflags -Wl,--as-needed
}

pkg_postinst() {
	elog
	elog "If after upgrading it doesn't work, please remove the"
	elog "'~/.config/deluge' directory and try again, but make a backup"
	elog "first!"
	elog
	elog "Please note that Deluge is still in it's early stages"
	elog "of development. Use it carefully and feel free to submit bugs"
	elog "in upstream page."
	elog
}
