# Copyright 1999-2004 Gentoo Technologies, Inc. and Shane Hathaway
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/childsplay/childsplay-0.68.ebuild,v 1.4 2004/02/20 06:42:26 mr_bones_ Exp $

inherit games

DESCRIPTION="A suite of educational games for young children"
HOMEPAGE="http://childsplay.sourceforge.net/"
SRC_URI="mirror://sourceforge/childsplay/${P}.tar.gz
	mirror://sourceforge/childsplay/${PN}-plugins-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.1
	>=dev-python/pygame-1.4
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/sdl-mixer"

src_unpack() {
	# Move the plugins into the main package.
	unpack ${A}
	PLUGINS=${PN}-plugins-${PV}
	cp -r ${PLUGINS}/Data/* ${P}/Data
	cp -r ${PLUGINS}/Lib/* ${P}/lib    # Note "Lib" vs. "lib"
	cp -r ${PLUGINS}/locale/* ${P}/locale
}

src_compile() {
	python -c "import compileall; compileall.compile_dir('.')"
	cp -r lib/MemoryData lib/LettersData
	# Fix a locale-related bug.  On some systems, the locale is "C".
	ln -s words-en lib/PackidData/words-C
}

src_install() {
	MYDATA=${GAMES_DATADIR}/childsplay
	MYSCORE=${GAMES_STATEDIR}/childsplay-scores

	dodir ${MYDATA}
	dodir ${GAMES_STATEDIR}
	dodir ${GAMES_BINDIR}
	dodir /usr/share/locale

	# Copy files, moving the scores file in the state directory
	# (usually /var/games).
	cp -r *.py *.py[co] Data lib ${D}/${MYDATA}
	mv -f ${D}/${MYDATA}/Data/score ${D}/${MYSCORE}
	ln -sf ${MYSCORE} ${D}/${MYDATA}/Data/score
	cp -r locale/* ${D}/usr/share/locale
	doman man/childsplay.6.gz
	dodoc doc/README* doc/changelog.text doc/copyright

	# Make a launcher.
	dogamesbin ${FILESDIR}/childsplay
	dosed "s:GENTOO_DIR:${MYDATA}:" ${GAMES_BINDIR}/childsplay

	prepgamesdirs
	fperms g+w ${MYSCORE}
}
