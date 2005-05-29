# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtorrent/libtorrent-0.6.2.ebuild,v 1.3 2005/05/29 22:26:24 flameeyes Exp $

inherit eutils

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/downloads/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="debug"

RDEPEND=">=dev-libs/libsigc++-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fbsd.patch
	epatch ${FILESDIR}/${P}-warns.patch

	./autogen.sh
}

src_compile() {
	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
