# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo2000/ufo2000-0.7.1062.ebuild,v 1.4 2007/03/12 18:13:00 genone Exp $

inherit toolchain-funcs games

DESCRIPTION="Free multiplayer remake of X-COM (UFO: Enemy Unknown)"
HOMEPAGE="http://ufo2000.sourceforge.net/"
SRC_URI="mirror://sourceforge/ufo2000/${P}-src.tar.bz2
	vorbis? ( mirror://sourceforge/ufo2000/ufo2000-music-20041222.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc x86"
IUSE="vorbis"
RESTRICT="test"

RDEPEND="dev-libs/expat
	>=dev-games/hawknl-1.66
	>=media-libs/allegro-4.2.0
	>=media-libs/freetype-2
	vorbis? ( ~media-libs/aldumb-0.9.2
		~media-libs/dumb-0.9.2
		media-libs/libogg
		media-libs/libvorbis )"
DEPEND="${RDEPEND}
	vorbis? ( app-arch/unzip )"

src_unpack() {
	unpack ${P}-src.tar.bz2

	cd "${S}"
	sed -i \
		-e "/^CX/s/g++/$(tc-getCXX)/" \
		-e "/^CC/s/gcc/$(tc-getCC)/" \
		makefile \
		|| die "sed failed"

	if use vorbis ; then
		cd "${S}/newmusic"
		unpack ufo2000-music-20041222.zip
	fi
}

src_compile() {
	emake \
		DATA_DIR="${GAMES_DATADIR}/${PN}" \
		OPTFLAGS="${CXXFLAGS}" \
		UFO_SVNVERSION=exported \
		$(use vorbis || echo no_dumbogg=1) \
		|| die "emake failed"
}

src_install() {
	dogamesbin ufo2000 || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r arts newmaps newmusic newunits init-scripts script \
		XCOM TFTD translations extensions fonts \
		*.dat squad.default.lua ufo2000.default.ini soundmap.xml \
		|| die "doins failed"
	keepdir "${GAMES_DATADIR}/${PN}/newmusic"
	dodir "${GAMES_DATADIR}"/${PN}/{XCOM,TFTD}
	echo "Please copy data files from X-COM here" > \
		"${D}/${GAMES_DATADIR}/${PN}/XCOM/readme.txt"
	echo "Please copy data files from TFTD here" > \
		"${D}/${GAMES_DATADIR}/${PN}/TFTD/readme.txt"
	dodoc *.txt INSTALL AUTHORS HACKING ChangeLog
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "If you have a full version of X-COM, you can copy all the files"
	elog "from the directory where you have it installed into:"
	elog "   ${GAMES_DATADIR}/${PN}/XCOM"
	elog
	elog "Likewise for Terror From The Deep, but to the directory:"
	elog "   ${GAMES_DATADIR}/${PN}/TFTD"
	elog
	elog "This will allow you to use more terrain types and units."
}
