# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/falconseye/falconseye-1.9.4a.ebuild,v 1.4 2004/02/03 20:48:08 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A graphical version of nethack (unofficially developed version 1.94)"
HOMEPAGE="http://falconseye.sourceforge.net/"
SRC_URI="http://cage.ugent.be/~jdemeyer/nethack/nethack-341-jtp-194a.tar.bz2"

KEYWORDS="x86 ppc"
LICENSE="nethack"
SLOT="0"
IUSE=""

DEPEND="media-libs/libsdl
	dev-util/yacc
	dev-util/byacc"
RDEPEND="media-libs/libsdl
	media-sound/timidity++
	media-sound/mpg123"

S=${WORKDIR}/nethack-341-jtp-194a

src_unpack() {
	unpack ${A}
	cd ${S}
	source sys/unix/setup.sh
	cd ../../

	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	epatch ${FILESDIR}/${PV}-default-options.patch
	sed -i "s:GENTOO_STATEDIR:${GAMES_STATEDIR}/${PN}:" include/unixconf.h || die "setting statedir"
	sed -i "s:GENTOO_HACKDIR:${GAMES_DATADIR}/${PN}:" include/config.h || die "seting hackdir"
	sed -i 's:/usr/local/bin/timidity:/usr/bin/timidity:' win/jtp/gamedata/config/jtp_opts.txt
}

src_compile() {
	emake -j1 \
		GAME=falconseye \
		CFLAGS="${CFLAGS} -I../include -I../win/jtp" \
		|| die "game failed"
	cd doc
	emake || die "doc failed"
}

src_install() {
	emake \
		GAMEPERM=0755 \
		PREFIX=${D}/usr \
		GAME=falconseye \
		GAMEUID=${GAMES_USER} \
		GAMEGRP=${GAMES_GROUP} \
		GAMEDIR=${D}/${GAMES_DATADIR}/${PN} \
		VARDIR=${D}/${GAMES_STATEDIR}/${PN} \
		SHELLDIR=${D}/${GAMES_BINDIR} \
		install \
		|| die "install failed"
	dosed "s:${D}/::" ${GAMES_BINDIR}/falconseye
	sed 's:nethack:falconseye:g' doc/nethack.6 > doc/falconseye.6
	doman doc/falconseye.6
	dodoc ChangeLog README falcon.txt
	prepgamesdirs
	chmod -R g+w ${D}/${GAMES_STATEDIR}
}
