# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/searchandrescue/searchandrescue-0.8.1.ebuild,v 1.2 2004/02/11 15:29:15 dholm Exp $

inherit games

MY_PN=SearchAndRescue
DESCRIPTION="aircraft based rescue simulator"
HOMEPAGE="http://wolfpack.twu.net/SearchAndRescue/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${MY_PN}-${PV}.tgz
	ftp://wolfpack.twu.net/users/wolfpack/${MY_PN}-data-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="joystick"

DEPEND="virtual/x11
	joystick? ( media-libs/libjsw )
	virtual/opengl"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${MY_PN}-${PV}.tgz
	mkdir data ; cd data
	unpack ${MY_PN}-data-${PV}.tgz
	cd ${S}
	bunzip2 sar/man/${MY_PN}.6.bz2
	sed -i "s:/usr/share/icons:/usr/share/icons/${PN}:g" sar/config.h
	sed -i '/FeatureCFLAGS.*march/s:=.*:=:g' sar/platforms.ini
}

src_compile() {
	local myjoyconf
	[ `use joystick` ] \
		&& myjoyconf="--enable=joystick" \
		|| myjoyconf="--disable=joystick"
	./configure \
		Linux \
		--prefix=${GAMES_PREFIX} \
		${myjoyconf} \
		|| die
	make || die
}

src_install() {
	dogamesbin sar/${MY_PN}
	insinto /usr/share/icons/${PN}
	doman sar/man/${MY_PN}.6
	doins sar/icons/*.{ico,xpm}
	dodoc AUTHORS HACKING README
	cd ${WORKDIR}/data
	dodir ${GAMES_DATADIR}/${MY_PN}
	cp -r * ${D}/${GAMES_DATADIR}/${MY_PN}/
	prepgamesdirs
}
