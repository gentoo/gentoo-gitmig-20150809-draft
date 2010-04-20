# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/freedoko/freedoko-0.7.3.ebuild,v 1.11 2010/04/20 19:10:58 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="FreeDoko is a Doppelkopf-game"
HOMEPAGE="http://free-doko.sourceforge.net"
SRC_URI="mirror://sourceforge/free-doko/FreeDoko_${PV}.src.zip
	kdecards? ( mirror://sourceforge/free-doko/kdecarddecks.zip )
	xskatcards? ( mirror://sourceforge/free-doko/xskat.zip )
	pysolcards? ( mirror://sourceforge/free-doko/pysol.zip )
	!altenburgcards? (
		!xskatcards? (
			!kdecards? (
				!pysolcards? ( mirror://sourceforge/free-doko/xskat.zip ) ) ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="xskatcards kdecards altenburgcards pysolcards net doc"

RDEPEND="net? ( net-libs/gnet )
	>=dev-cpp/gtkmm-2.4"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/pkgconfig
	doc? ( virtual/latex-base )"

S=${WORKDIR}/FreeDoko_${PV}

src_unpack() {
	unpack FreeDoko_${PV}.src.zip
	cd "${S}"
	edos2unix src/Makefile.rules
	epatch \
		"${FILESDIR}"/portage-cxx.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/Fix_Cardset_Make.patch
	use !doc && epatch "${FILESDIR}"/nodoc.patch
	use !net && epatch "${FILESDIR}"/nonet.patch
	sed -i \
		-e 's/linux binary/Gentoo '${ARCH}' binary/g' \
		-e '/strip\ .*/d' \
		Makefile \
		|| die "sed failed"

	cd data/cardsets
	use xskatcards && unpack xskat.zip
	use kdecards && unpack kdecarddecks.zip
	use pysolcards && unpack pysol.zip
	if use xskatcards || use kdecards || use pysolcards ; then
		use altenburgcards || rm -r Altenburg
	fi
	if use !altenburgcards && use !xskatcards && use !kdecards && use !pysolcards ; then
		ewarn "You did not choose any cardset!"
		ewarn "I will install the cardset xskat"
		ewarn "You may change your mind and hit"
		ewarn "CTRL+C NOW to choose the cardsets"
		ewarn "with the USE-Flags"
		ebeep
		rm -r Altenburg && unpack xskat.zip
	fi

}

src_compile() {
	export CPPFLAGS="-DPUBLIC_DATA_DIRECTORY_VALUE='\"${GAMES_DATADIR}/${PN}\"'"
	export OSTYPE=Linux
	emake release_directory || die "build failed"
	emake release_data || die "build failed"
	emake release_linux_binary || die "build failed"
}

src_install() {
	newgamesbin release/FreeDoko_${PV}/FreeDoko freedoko || die "installing the binary failed"
	rm -f release/FreeDoko_${PV}/FreeDoko
	insinto "${GAMES_DATADIR}"/${PN}/
	doins -r release/FreeDoko_${PV}/* || die "Installation failed"
	dodoc README LIESMICH ChangeLog
	newicon src/FreeDoko.png ${PN}.png
	make_desktop_entry ${PN} FreeDoko
	prepgamesdirs
}

pkg_postinst () {
	games_pkg_postinst
	if use altenburgcards; then
		elog "License Info:"
		elog "Verwendung der ASS Altenburger Spielkarten mit Genehmigung"
		elog "der Spielkartenfabrik Altenburg GmbH"
	fi
}
