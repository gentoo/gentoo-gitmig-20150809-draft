# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-9999.ebuild,v 1.16 2009/02/12 15:46:21 armin76 Exp $

inherit eutils distutils subversion flag-o-matic

ESVN_REPO_URI="http://svn.deluge-torrent.org/trunk"
ESVN_PROJECT="deluge"

DESCRIPTION="BitTorrent client with a client/server model."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

DEPEND=">=dev-lang/python-2.4
	dev-libs/boost
	dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-python/pyxdg
	dev-python/pygobject
	dev-python/twisted
	dev-python/twisted-web
	dev-python/simplejson
	dev-python/pyopenssl
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
