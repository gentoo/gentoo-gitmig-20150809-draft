# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gtans/gtans-1.2.ebuild,v 1.7 2005/05/15 21:17:06 mr_bones_ Exp $

inherit toolchain-funcs games

DESCRIPTION="The Tangram is a chinese puzzle of shapes"
HOMEPAGE="http://gtans.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.1
	dev-libs/glib
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	if ! use nls ; then
		sed -i \
			-e "/\(TGTXT\| po\)/ s/^/#/" \
			-e "/^CC/ s:=.*:= $(tc-getCC):" \
			-e "/misc/ s/PREFIX.*/install/" \
			-e "/^CFLG[ 	]*=/ s:=.*:= ${CFLAGS}:" makefile \
			|| die "sed failed"
	fi
	sed -i \
		-e "s:/share::" \
		-e "/^PREFIX/ s:usr:usr/share:" misc/Makefile \
		|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS HISTORY
	prepgamesdirs
}
