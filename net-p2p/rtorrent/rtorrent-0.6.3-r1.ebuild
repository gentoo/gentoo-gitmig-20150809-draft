# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/rtorrent/rtorrent-0.6.3-r1.ebuild,v 1.1 2006/10/19 01:25:33 flameeyes Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=net-libs/libtorrent-0.10.1
	>=dev-libs/libsigc++-2.0
	>=net-misc/curl-7.12
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	sys-devel/bc"

src_compile() {
	replace-flags -Os -O2

	if [[ $(tc-arch) = "x86" ]]; then
		filter-flags -fomit-frame-pointer

		# See bug #151221. It seems only to hit on GCC 4.1 and x86 architecture
		# it could be safer to fallback to -O1, but with the high use of STL in
		# rtorrent, that could make it too slow.
		[[ $(gcc-major-version)$(gcc-minor-version) == "41" ]] && replace-flags -O2 -O3
	fi

	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "emake failed"
}

pkg_postinst() {
	einfo "rtorrent now supports a configuration file."
	einfo "A sample configuration file for rtorrent is can be found"
	einfo "in ${ROOT}usr/share/doc/${PF}/rtorrent.rc.gz."
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO doc/rtorrent.rc
}
