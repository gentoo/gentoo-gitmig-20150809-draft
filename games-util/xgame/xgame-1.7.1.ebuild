# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xgame/xgame-1.7.1.ebuild,v 1.1 2004/12/03 14:40:56 citizen428 Exp $

inherit eutils

IUSE=""

DESCRIPTION="Run games in a separate X session"
HOMEPAGE="http://xgame.tlhiv.com/"
SRC_URI="http://downloads.tlhiv.com/xgame/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="dev-lang/perl"

src_install() {
	exeinto /usr/games/bin
	exeopts -m0650
	doexe xgame || die "doexe failed"
	# Only members of the group 'games' can use this
	fowners root:games /usr/games/bin/xgame || die "fowner failed"
	dodoc README || die "dodoc failed"
}

pkg_postinst() {
	echo
	ewarn "Remember, in order to play games, you have to"
	ewarn "be in the 'games' group."
	echo
	einfo "See the usermod(8) manpage for more information."
	echo
}
