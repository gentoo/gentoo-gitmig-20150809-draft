# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo2000/ufo2000-0.4.0_beta324.ebuild,v 1.1 2004/01/31 01:02:18 mr_bones_ Exp $

inherit games

DESCRIPTION="Free multiplayer remake of X-COM (UFO: Enemy Unknown)"
HOMEPAGE="http://ufo2000.sourceforge.net/"
SRC_URI="http://ufo2000.lxnt.info/files/${P}-src.tar.bz2
	ftp://ftp.microprose.com/pub/mps-online/x-com/xcomdemo.zip
	ftp://ftp.microprose.com/pub/mps-online/demos/terror.zip"

KEYWORDS="-* ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	>=media-libs/allegro-4.0.0
	>=dev-lang/lua-5.0
	>=dev-games/hawknl-1.66
	dev-libs/expat"

src_unpack() {
	unpack ${P}-src.tar.bz2

	cd "${WORKDIR}/${P}/XCOMDEMO"
	unpack xcomdemo.zip
	unzip -LL XCOM.EXE -d ..
	rm XCOM.EXE
	mv ../xcomdemo/* "${WORKDIR}/${P}/XCOMDEMO/"

	cd "${WORKDIR}/${P}/TFTDDEMO"
	unpack terror.zip
	unzip -LL TFTD.ZIP
	rm TFTD.ZIP
}

src_compile() {
	emake \
		DATA_DIR="${GAMES_DATADIR}/${PN}" \
		OPTFLAGS="${CXXFLAGS}" \
			|| die "emake failed"
}

src_install() {
	dogamesbin ufo2000 || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R arts newmaps init-scripts XCOMDEMO XCOM TFTDDEMO TFTD \
		ufo2000.dat keyboard.dat geodata.dat soldier.dat armoury.set \
		items.dat ufo2000.ini soundmap.xml "${D}/${GAMES_DATADIR}/${PN}" \
			|| die "cp failed"
	echo "Please copy data files from X-COM here" > \
		"${D}/${GAMES_DATADIR}/${PN}/XCOM/readme.txt"
	echo "Please copy data files from TFTD here" > \
		"${D}/${GAMES_DATADIR}/${PN}/TFTD/readme.txt"
	dodoc *.txt INSTALL AUTHORS ChangeLog || die "dodoc failed"
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
