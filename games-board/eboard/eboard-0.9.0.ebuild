# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/eboard/eboard-0.9.0.ebuild,v 1.2 2004/01/03 03:38:56 mr_bones_ Exp $

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
	[ ! `use nls` ] && cd ${S} && epatch ${FILESDIR}/${PV}-fake-nls.patch
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	egamesinstall || die
	dodoc README AUTHORS COPYING ChangeLog INSTALL NEWS TODO
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
