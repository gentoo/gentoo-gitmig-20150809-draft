# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gtans/gtans-1.2.ebuild,v 1.1 2004/01/28 10:44:32 mr_bones_ Exp $

inherit games

DESCRIPTION="The Tangram is a chinese puzzle. The object is to put seven geometric shapes together so as to form a given outline."
HOMEPAGE="http://gtans.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/gtans/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.1
	dev-libs/glib
	nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	if ! use nls ; then
		sed -i \
			-e "/\(TGTXT\| po\)/ s/^/#/" \
			-e "/^CC/ s:=.*:= ${CC}:" \
			-e "/misc/ s/PREFIX.*/install/" \
			-e "/^CFLG[ 	]*=/ s:=.*:= ${CFLAGS}:" makefile \
				|| die "sed makefile failed"
	fi
	sed -i \
		-e "s:/share::" \
		-e "/^PREFIX/ s:usr:usr/share:" misc/Makefile \
			|| die "sed misc/Makefile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS HISTORY       || die "dodoc failed"
	prepgamesdirs
}
