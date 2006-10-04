# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gtans/gtans-1.2.ebuild,v 1.10 2006/10/04 18:06:54 nyhm Exp $

inherit toolchain-funcs games

DESCRIPTION="The Tangram is a chinese puzzle of shapes"
HOMEPAGE="http://gtans.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^CC/s:gcc:$(tc-getCC):" \
		-e "/^CFLG/s:-O2:${CFLAGS}:" \
		-e "/^LDFLG/s:$: ${LDFLAGS}:" \
		-e '/$(INSTALL)/s:-s::' \
		-e "/^HOMEDIR/s:=.*:=${GAMES_DATADIR}/${PN}/:" \
		-e "/^EXECDIR/s:=.*:=${GAMES_BINDIR}/:" \
		makefile || die "sed failed"

	sed -i 's:/man/:/share/man/:' misc/Makefile \
		|| die "sed misc/Makefile failed"

	if ! use nls ; then
		sed -i \
			-e '/DTGTXT/d' \
			-e '/cd po/d' \
			makefile || die "sed nls failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS HISTORY
	prepgamesdirs
}
