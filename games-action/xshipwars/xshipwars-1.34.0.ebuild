# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xshipwars/xshipwars-1.34.0.ebuild,v 1.5 2004/03/31 03:35:27 mr_bones_ Exp $

inherit gcc eutils games

MY_P=xsw-${PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="massively multi-player, ultra graphical, space-oriented gaming system designed exclusively for network play"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${MY_P}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/xswdata-1.33d.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/stimages1.7.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/babylon5images1.1.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/stsounds1.4.tgz"
HOMEPAGE="http://wolfpack.twu.net/ShipWars/XShipWars/"

LICENSE="GPL-2 xshipwars"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	>=media-sound/esound-0.2.23
	virtual/x11"

src_unpack() {
	unpack ${MY_P}.tar.bz2
}

src_compile() {
	./configure.client Linux --prefix=/usr || die
	./configure.monitor Linux --prefix=/usr || die
	./configure.server Linux --prefix=${GAMES_PREFIX} || die
	./configure.unvedit Linux --prefix=/usr || die

	[ `gcc-major-version` == 3 ] && epatch ${FILESDIR}/${P}-gcc3.patch

	for makefile in Makefile.* ; do
		make \
			-f ${makefile} \
			CPPFLAGS="-D__cplusplus -Dc_plusplus ${CFLAGS}" \
			all || die
	done
}

src_install() {
	make -f Makefile.client PREFIX=${D}/usr install || die
	make -f Makefile.monitor PREFIX=${D}/usr install || die
	make -f Makefile.server PREFIX=${D}/${GAMES_PREFIX} install || die
	make -f Makefile.unvedit PREFIX=${D}/usr install || die

	dodir ${GAMES_DATADIR}/${PN}
	tar -jxC ${D}/${GAMES_DATADIR}/${PN} -f ${DISTDIR}/xswdata-1.33d.tar.bz2
	tar -jxC ${D}/${GAMES_DATADIR}/${PN} -f ${DISTDIR}/stimages1.7.tar.bz
	tar -jxC ${D}/${GAMES_DATADIR}/${PN} -f ${DISTDIR}/babylon5images1.1.tar.bz2
	tar -zxC ${D}/${GAMES_DATADIR}/${PN} -f ${DISTDIR}/stsounds1.4.tgz

	# put the binaries in the right place
	dodir ${GAMES_BINDIR}
	mv ${D}/usr/games/{unvedit,xsw,monitor} ${D}/${GAMES_BINDIR}/

	prepgamesdirs
}

pkg_postinst() {
	echo
	einfo "Before playing, you should get a copy of the installed "
	einfo "global XShipWars client configuration file and copy it to "
	einfo "your home directory: "
	echo
	einfo "# mkdir ~/.shipwars/"
	einfo "# cd /usr/share/games/xshipwars/etc/ "
	einfo "# cp xshipwarsrc ~/.shipwars/xshipwarsrc "
	einfo "# cp universes ~/.shipwars/universes "
	echo
	einfo "You will probably need to edit the xshipwarsrc to fit your needs."
	echo
	einfo "Then type 'xsw &' to start the game"
	echo
}
