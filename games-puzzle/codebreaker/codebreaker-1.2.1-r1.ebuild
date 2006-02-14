# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/codebreaker/codebreaker-1.2.1-r1.ebuild,v 1.6 2006/02/14 04:29:18 joshuabaergen Exp $

inherit games

DESCRIPTION="mastermind style game"
HOMEPAGE="http://packages.debian.org/codebreaker"
SRC_URI="mirror://debian/pool/main/c/codebreaker/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="|| ( x11-libs/libXi virtual/x11 )
	=x11-libs/gtk+-1.2*"

S="${WORKDIR}/${P}.orig"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		'/-DHOWTO=/s:\${prefix}/doc/\$(PACKAGE)-\$(VERSION):/usr/share/doc/${PF}:' \
		src/Makefile.in
}

src_install() {
	dogamesbin src/codebreaker
	dodoc README AUTHORS
	insinto /usr/share/doc/${PF}
	doins doc/HOWTO # don't gzip this #38128
	prepgamesdirs
}
