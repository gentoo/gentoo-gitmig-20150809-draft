# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtorrent/libtorrent-0.4.1.ebuild,v 1.1 2004/11/23 21:55:44 squinky86 Exp $

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE="ncurses"

RDEPEND="dev-libs/openssl
	>=net-misc/curl-7.12
	>=dev-libs/libsigc++-2
	ncurses? ( >=sys-libs/ncurses-5.4 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ncurses && cp client/Makefile2 client/Makefile
}

src_compile() {
	econf || die
	emake || die
	use ncurses && emake -C client || die
}

src_install() {
	einstall || die
	use ncurses && dobin client/rtorrent
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
	use ncurses && newdoc client/README README.rtorrent
}
