# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.8.1.ebuild,v 1.2 2004/07/15 00:08:16 vapier Exp $

inherit games eutils

MY_P="${PN}-src-${PV}"
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.tar.bz2
	mirror://sourceforge/attal/themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/qt-3*"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
	for lib in Client Common Fight Server ; do
		sed -i \
			-e "/^TARGET/s:= ${lib}:= ${PN}${lib}:" \
			-e "s:lib${lib}\.so:lib${PN}${lib}.so:g" \
			-e "s:-l${lib}:-l${PN}${lib}:g" \
			*/*.pro \
			|| die "renaming ${lib}"
	done
	qmake -o Makefile Makefile.pro || die "qmake failed"
	sed -i \
		"s:\./themes/:${GAMES_DATADIR}/${PN}/themes/:" \
		`grep -Rl '\./themes/' *` \
		|| die "fixing theme loc"
	find "${WORKDIR}/themes" -name .cvsignore -exec rm -f \{\} \;
}

src_compile() {
	# broken deps in the makefiles ...
	emake \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		sub-libCommon || die "emake sub-libCommon failed"
	emake \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		sub-{libFight,libClient,libServer} || die "emake libs failed"
	emake \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		|| die "emake failed"
}

src_install() {
	dogamesbin attal-* || die "dogamesbin failed"
	into "${GAMES_PREFIX}"
	dolib.so lib*.so* || die "dolib.so failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r "${WORKDIR}/themes" "${D}/${GAMES_DATADIR}/${PN}/themes" \
		|| die "cp failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
