# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.11.ebuild,v 1.12 2009/01/29 02:20:15 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://tetrinet.or.cz/"
SRC_URI="http://tetrinet.or.cz/download/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-ipv6.patch

	use ipv6 && append-flags -DHAVE_IPV6
	sed -i \
		-e '/^CC/d' \
		-e 's/-DHAVE_IPV6//' \
		-e "s:-O2:${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin tetrinet tetrinet-server || die "dogamesbin failed"
	dodoc README TODO tetrinet.txt
	prepgamesdirs
}
