# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-0.5.9.3.ebuild,v 1.4 2009/03/07 15:08:33 betelgeuse Exp $

EAPI="2"

inherit eutils distutils flag-o-matic

DESCRIPTION="BitTorrent client in Python and PyGTK."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://download.deluge-torrent.org/source/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE="libnotify"

S="${WORKDIR}"/${PN}-torrent-${PV}

DEPEND=">=dev-lang/python-2.3
	|| ( >=dev-libs/boost-1.34 ~dev-libs/boost-1.33.1[threads] )"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2
	dev-python/pyxdg
	dev-python/dbus-python
	gnome-base/librsvg
	libnotify? ( dev-python/notify-python )"

pkg_setup() {
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
