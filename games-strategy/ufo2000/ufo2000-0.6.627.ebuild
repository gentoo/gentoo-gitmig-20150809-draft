# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo2000/ufo2000-0.6.627.ebuild,v 1.4 2005/06/15 19:13:18 wolf31o2 Exp $

inherit games

DESCRIPTION="Free multiplayer remake of X-COM (UFO: Enemy Unknown)"
HOMEPAGE="http://ufo2000.sourceforge.net/"
SRC_URI="http://ufo2000.lxnt.info/files/${P}-src.tar.bz2
	ftp://ftp.microprose.com/pub/mps-online/x-com/xcomdemo.zip
	ftp://ftp.microprose.com/pub/mps-online/demos/terror.zip
	oggvorbis? ( http://ufo2000.lxnt.info/files/ufo2000-music-20041222.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc x86"
IUSE="oggvorbis"

RDEPEND="virtual/libc
	dev-libs/expat
	>=dev-games/hawknl-1.66
	>=media-libs/allegro-4.0.0
	oggvorbis? ( >=media-libs/aldumb-0.9.2
		media-libs/libogg
		media-libs/libvorbis )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${P}-src.tar.bz2

	cd "${S}/XCOMDEMO"
	unpack xcomdemo.zip
	unzip -qLL XCOM.EXE -d .. || die "unzip failed"
	rm XCOM.EXE
	mv ../xcomdemo/* "${S}/XCOMDEMO/" || die "mv failed"

	cd "${S}/TFTDDEMO"
	unpack terror.zip
	unzip -qLL TFTD.ZIP || die "unzip failed"
	rm TFTD.ZIP

	if use oggvorbis ; then
		cd "${S}/newmusic"
		unpack ufo2000-music-20041222.zip
	fi
}

src_compile() {
	local myconf

	use oggvorbis && myconf="dumbogg=1"

	emake \
		DATA_DIR="${GAMES_DATADIR}/${PN}" \
		OPTFLAGS="${CXXFLAGS}" \
		${myconf} \
		|| die "emake failed"
}

src_install() {
	dogamesbin ufo2000 || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R arts newmaps newmusic newunits init-scripts script \
		XCOMDEMO XCOM TFTDDEMO TFTD translations \
		*.dat ufo2000.default.ini soundmap.xml \
			"${D}/${GAMES_DATADIR}/${PN}" \
				|| die "cp failed"
	keepdir "${GAMES_DATADIR}/${PN}/newmusic"
	echo "Please copy data files from X-COM here" > \
		"${D}/${GAMES_DATADIR}/${PN}/XCOM/readme.txt"
	echo "Please copy data files from TFTD here" > \
		"${D}/${GAMES_DATADIR}/${PN}/TFTD/readme.txt"
	dodoc *.txt AUTHORS ChangeLog || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "If you have a full version of X-COM, you can copy all the files"
	einfo "from the directory where you have it installed into:"
	einfo "   ${GAMES_DATADIR}/${PN}/XCOM"
	echo
	einfo "Likewise for Terror From The Deep, but to the directory:"
	einfo "   ${GAMES_DATADIR}/${PN}/TFTD"
	echo
	einfo "This will allow you to use more terrain types and units."
	echo
}
