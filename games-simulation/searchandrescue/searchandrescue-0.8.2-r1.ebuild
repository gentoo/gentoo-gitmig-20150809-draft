# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/searchandrescue/searchandrescue-0.8.2-r1.ebuild,v 1.1 2007/05/31 20:55:43 tupone Exp $

inherit eutils games

MY_PN=SearchAndRescue
DESCRIPTION="Helicopter based air rescue flight simulator"
HOMEPAGE="http://wolfpack.twu.net/SearchAndRescue/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${MY_PN}-${PV}.tar.bz2
	ftp://wolfpack.twu.net/users/wolfpack/${MY_PN}-data-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="joystick"

RDEPEND="x11-libs/libXxf86vm
	x11-libs/libXmu
	x11-libs/libXi
	x11-libs/libXpm
	virtual/opengl
	virtual/glu
	media-libs/yiff
	joystick? ( media-libs/libjsw )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${MY_PN}-${PV}.tar.bz2
	mkdir data ; cd data
	unpack ${MY_PN}-data-${PV}.tar.bz2
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc33.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-gcc412.patch
	bunzip2 sar/man/${MY_PN}.6.bz2
	sed -i \
		-e '/FeatureCFLAGS.*march/s:=.*:=:g' sar/platforms.ini \
		|| die "sed failed"
	sed -i \
		-e "1i\#include <stdio.h>
		" sar/gctl.c \
		|| die "sed failed"
}

src_compile() {
	local myconf

	use joystick \
		&& myconf="--enable=libjsw" \
		|| myconf="--disable=libjsw"

	# NOTE: not an autoconf script
	./configure Linux \
		--prefix="${GAMES_PREFIX}" \
		${myconf} \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin sar/${MY_PN} || die "dogamesbin failed"
	doman sar/man/${MY_PN}.6
	insinto /usr/share/icons/
	doins sar/icons/*.{ico,xpm}
	dodoc AUTHORS HACKING README
	newicon sar/icons/SearchAndRescue.xpm ${PN}.xpm
	cd "${WORKDIR}/data"
	dodir "${GAMES_DATADIR}/${MY_PN}"
	cp -r * "${D}/${GAMES_DATADIR}/${MY_PN}/" || die "cp failed"
	make_desktop_entry SearchAndRescue "SearchAndRescue" \
		/usr/share/pixmaps/${PN}.xpm
	prepgamesdirs
}
