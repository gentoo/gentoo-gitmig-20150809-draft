# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/eboard/eboard-0.9.5.ebuild,v 1.1 2004/01/02 02:16:32 vapier Exp $

inherit games eutils

EXTRAS1=eboard-extras-1pl2
EXTRAS2=eboard-extras-2
DESCRIPTION="chess interface for POSIX systems"
HOMEPAGE="http://eboard.sourceforge.net/"
SRC_URI="mirror://sourceforge/eboard/${P}.tar.gz
	mirror://sourceforge/eboard/${EXTRAS1}.tar.gz
	mirror://sourceforge/eboard/${EXTRAS2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	>=media-libs/imlib-1.9.7
	dev-lang/perl
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O6:${CXXFLAGS}:" configure
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die
}

src_install() {
	emake install \
		prefix=${D}/${GAMES_PREFIX} \
		bindir=${D}/${GAMES_BINDIR} \
		mandir=${D}/usr/share/man \
		datadir=${D}/${GAMES_DATADIR}/${PN} \
		|| die
	dodoc README AUTHORS ChangeLog TODO
	dodoc Documentation/*

	insinto ${GAMES_DATADIR}/eboard
	cd ${WORKDIR}/${EXTRAS1}
	doins *.png *.wav
	newins extras1.conf themeconf.extras1
	newdoc ChangeLog Changelog.extras
	newdoc README README.extras
	dodoc CREDITS
	cd ${WORKDIR}/${EXTRAS2}
	doins *.png *.wav
	newins extras2.conf themeconf.extras2

	prepgamesdirs
}
