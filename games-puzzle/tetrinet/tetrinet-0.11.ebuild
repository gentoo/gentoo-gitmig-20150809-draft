# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.11.ebuild,v 1.2 2003/10/04 21:43:38 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://tetrinet.or.cz/"
SRC_URI="http://tetrinet.or.cz/download/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="ipv6"

RDEPEND=">=sys-libs/ncurses-5"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	[ `use ipv6` ] && append-flags -DHAVE_IPV6

	sed -i \
		-e 's/-DHAVE_IPV6//' \
		-e "s:-O2:${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	dogamesbin tetrinet tetrinet-server || die "dogamesbin failed"
	dodoc README TODO tetrinet.txt      || die "dodoc failed"
	prepgamesdirs
}
