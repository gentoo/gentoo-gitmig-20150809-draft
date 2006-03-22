# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/wmquake/wmquake-1.1.ebuild,v 1.6 2006/03/22 16:03:14 mr_bones_ Exp $

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
	exeinto "${GAMES_LIBDIR}/wmquake"
	doexe wmquake || die "doexe failed"
	games_make_wrapper wmquake "${GAMES_LIBDIR}/wmquake/wmquake" "${GAMES_DATADIR}/quake1/"
	dodoc README*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Before you can play, you must make sure"
	einfo "wmquake can find your Quake .pak files"
	echo
	einfo "You have 2 choices to do this"
	einfo "1 Copy pak*.pak files to ${GAMES_DATADIR}/quake1/id1"
	einfo "2 Symlink pak*.pak files in ${GAMES_DATADIR}/quake1/id1"
	echo
	einfo "Example:"
	einfo "my pak*.pak files are in /mnt/secondary/Games/Quake/Id1/"
	einfo "ln -s /mnt/secondary/Games/Quake/Id1/pak0.pak ${GAMES_DATADIR}/quake1/id1/pak0.pak"
	echo
	einfo "You only need pak0.pak to play the demo version,"
	einfo "the others are needed for registered version"
}
