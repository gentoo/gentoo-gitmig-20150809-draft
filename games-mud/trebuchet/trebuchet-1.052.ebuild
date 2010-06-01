# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/trebuchet/trebuchet-1.052.ebuild,v 1.7 2010/06/01 11:50:02 tupone Exp $
EAPI="2"

inherit games

MY_P="TrebTk${PV/./}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A crossplatform TCL/TK based MUD client"
HOMEPAGE="http://belfry.com/fuzzball/trebuchet/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-lang/tk-8.3.3
	dev-lang/tcl"

src_prepare() {
	sed -i \
		-e "/Nothing/d" \
		-e "/LN/ s:../libexec:${GAMES_DATADIR}:" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	make prefix="${D}${GAMES_PREFIX}" \
		ROOT="${D}${GAMES_DATADIR}/${PN}" \
			install || die "make install failed"
	# gui uses the COPYING file
	cp COPYING "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc changes.txt ideas.txt proxysam.txt readme.txt trebtodo.txt
	prepgamesdirs
}
