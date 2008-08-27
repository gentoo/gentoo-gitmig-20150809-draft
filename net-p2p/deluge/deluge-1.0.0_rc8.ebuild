# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-1.0.0_rc8.ebuild,v 1.1 2008/08/27 09:45:29 armin76 Exp $

inherit eutils distutils flag-o-matic

MY_PV="0.9.08"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="BitTorrent client with a client/server model."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://download.deluge-torrent.org/source/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

S="${WORKDIR}"/${MY_P}

DEPEND=">=dev-lang/python-2.4
	dev-libs/boost
	dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-python/pyxdg
	dev-python/pygobject
	gtk? (
		>=dev-python/pygtk-2
		dev-python/pyxdg
		dev-python/dbus-python
		gnome-base/librsvg
	)"

pkg_setup() {
	if ! built_with_use --missing true "dev-libs/boost" threads; then
		eerror "dev-libs/boost has to be built with threads USE-flag."
		die "Missing threads USE-flag for dev-libs/boost"
	fi

	filter-ldflags -Wl,--as-needed
}

src_unpack() {
	distutils_src_unpack

	cd "${S}"

	epatch "${FILESDIR}"/setup.patch
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}"/deluged.init deluged
	newconfd "${FILESDIR}"/deluged.conf deluged
}

pkg_postinst() {
	elog
	elog "If after upgrading it doesn't work, please remove the"
	elog "'~/.config/deluge' directory and try again, but make a backup"
	elog "first!"
	elog
	einfo "Please note that Deluge is still in it's early stages"
	einfo "of development. Use it carefully and feel free to submit bugs"
	einfo "in upstream page."
	elog
	elog "To start the daemon either run 'deluged' as user"
	elog "or modify /etc/conf.d/deluged and run"
	elog "/etc/init.d/deluged start as root"
	elog "You can still use deluge the old way"
	elog
	elog "For more information look at http://dev.deluge-torrent.org/wiki/Faq"
	elog
}
