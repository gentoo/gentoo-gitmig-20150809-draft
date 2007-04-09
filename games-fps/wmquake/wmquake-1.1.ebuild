# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/wmquake/wmquake-1.1.ebuild,v 1.8 2007/04/09 18:23:25 nyhm Exp $

inherit games

DESCRIPTION="Quake1 in a dockapp window"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e "s:CFLAGS = .*:CFLAGS = ${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	exeinto "$(games_get_libdir)/wmquake"
	doexe wmquake || die "doexe failed"
	games_make_wrapper wmquake "$(games_get_libdir)/wmquake/wmquake" "${GAMES_DATADIR}/quake1/"
	dodoc README*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "Before you can play, you must make sure"
	elog "wmquake can find your Quake .pak files"
	elog
	elog "You have 2 choices to do this"
	elog "1 Copy pak*.pak files to ${GAMES_DATADIR}/quake1/id1"
	elog "2 Symlink pak*.pak files in ${GAMES_DATADIR}/quake1/id1"
	elog
	elog "Example:"
	elog "my pak*.pak files are in /mnt/secondary/Games/Quake/Id1/"
	elog "ln -s /mnt/secondary/Games/Quake/Id1/pak0.pak ${GAMES_DATADIR}/quake1/id1/pak0.pak"
	elog
	elog "You only need pak0.pak to play the demo version,"
	elog "the others are needed for registered version"
}
