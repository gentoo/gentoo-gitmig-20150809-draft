# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-0.5.0.ebuild,v 1.6 2007/05/07 13:58:13 armin76 Exp $

inherit eutils distutils

DESCRIPTION="BitTorrent client in Python and PyGTK."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://deluge-torrent.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="libnotify"

DEPEND=">=dev-lang/python-2.3
	dev-libs/boost
	=net-libs/rb_libtorrent-0.11"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2
	dev-python/pyxdg
	dev-python/dbus-python
	libnotify? ( dev-python/notify-python )"

pkg_setup() {
	if has_version "<dev-libs/boost-1.34" && \
		! built_with_use "dev-libs/boost" threads; then
		eerror "dev-libs/boost has to be built with threads USE-flag."
		die "Missing threads USE-flag for dev-libs/boost"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-use-system-rblibtorrent.patch

	# use the threaded libs
	sed -i -e "s:\('boost_[^']*\):\1-mt:g" setup.py \
		|| die "sed failed"

	# http://deluge-torrent.org/ticket/173
	sed -i -e "s~INSTALL_PREFIX = '@datadir@'~INSTALL_PREFIX = '/usr'~g" \
		src/dcommon.py || die "sed failed"
}

src_compile() {
	if use amd64 || use ia64 || use ppc64; then
		CFLAGS="${CFLAGS} -DAMD64"
	fi
	distutils_src_compile
}

pkg_postinst() {
	elog
	elog "Please note that Deluge is still in it's early stages"
	elog "of development. Use it carefully and feel free to submit bugs"
	elog "in upstream page."
	elog
}
