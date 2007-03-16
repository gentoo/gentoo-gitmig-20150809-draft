# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-0.5.0_rc2.ebuild,v 1.2 2007/03/16 19:44:45 armin76 Exp $

inherit eutils distutils

MY_P="${PN}-0.4.99.2"

DESCRIPTION="BitTorrent client in Python and PyGTK."
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://deluge-torrent.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

DEPEND=">=dev-lang/python-2.3
	dev-libs/boost
	>=net-libs/rb_libtorrent-0.11"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2
	dev-python/pyxdg
	dev-python/dbus-python
	libnotify? ( dev-python/notify-python )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! built_with_use "dev-libs/boost" threads; then
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
