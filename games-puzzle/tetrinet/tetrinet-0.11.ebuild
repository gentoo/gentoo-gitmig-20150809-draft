# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.11.ebuild,v 1.10 2006/12/06 17:27:19 wolf31o2 Exp $

inherit flag-o-matic games

DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://tetrinet.or.cz/"
SRC_URI="http://tetrinet.or.cz/download/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE="ipv6"

RDEPEND=">=sys-libs/ncurses-5"

src_unpack() {
	unpack ${A}
	return 0
	cd "${S}"

	# for now, make sure IPv6 is always on #32860
	use ipv6 && append-flags -DHAVE_IPV6
	sed -i \
		-e 's/-DHAVE_IPV6//' \
		-e "s:-O2:${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin tetrinet tetrinet-server || die "dogamesbin failed"
	dodoc README TODO tetrinet.txt
	prepgamesdirs
}
