# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gtans/gtans-1.2.ebuild,v 1.6 2004/11/05 04:50:35 josejx Exp $

inherit games gcc

DESCRIPTION="The Tangram is a chinese puzzle of shapes"
HOMEPAGE="http://gtans.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="nls"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.1
	dev-libs/glib
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	if ! use nls ; then
		sed -i \
			-e "/\(TGTXT\| po\)/ s/^/#/" \
			-e "/^CC/ s:=.*:= $(gcc-getCC):" \
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
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS HISTORY
	prepgamesdirs
}
