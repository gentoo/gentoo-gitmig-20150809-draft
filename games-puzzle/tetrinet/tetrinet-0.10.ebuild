# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.10.ebuild,v 1.2 2003/10/03 03:49:30 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://achurch.org/tetrinet/"
SRC_URI="http://achurch.org/tetrinet/tetrinet.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5"

S=${WORKDIR}/tetrinet

src_compile() {
	[ `use ipv6` ] && append-flags -DHAVE_IPV6
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dogamesbin tetrinet tetrinet-server
	dodoc README TODO tetrinet.txt
	prepgamesdirs
}
