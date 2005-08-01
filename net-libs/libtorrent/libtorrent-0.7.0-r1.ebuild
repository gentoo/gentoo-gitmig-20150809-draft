# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtorrent/libtorrent-0.7.0-r1.ebuild,v 1.2 2005/08/01 01:09:33 flameeyes Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/downloads/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug"

RDEPEND=">=dev-libs/libsigc++-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Upstream patch for 0.7.0-1 version
	epatch ${FILESDIR}/${P}-1.diff
}

src_compile() {
	[[ $(tc-arch) = "x86" ]] && filter-flags -fomit-frame-pointer

	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		|| die "econf failed"
	
	# This is needed until the proper cflags patch is applied
	# Saves us from running autoconf and stuff.
	emake AM_CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
