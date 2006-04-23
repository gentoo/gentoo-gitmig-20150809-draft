# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/rtorrent/rtorrent-0.5.0.ebuild,v 1.2 2006/04/23 09:29:23 flameeyes Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND=">=net-libs/libtorrent-0.9.0
	>=dev-libs/libsigc++-2.0
	>=net-misc/curl-7.12
	sys-libs/ncurses"

src_compile() {
	[[ $(tc-arch) = "x86" ]] && filter-flags -fomit-frame-pointer
	replace-flags -Os -O2

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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO doc/rtorrent.rc
}
