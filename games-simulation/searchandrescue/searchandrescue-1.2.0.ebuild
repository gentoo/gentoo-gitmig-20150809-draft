# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/searchandrescue/searchandrescue-1.2.0.ebuild,v 1.1 2011/03/09 18:02:00 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs games

MY_DATA_PV=1.0.0
MY_PN=SearchAndRescue
DESCRIPTION="Helicopter based air rescue flight simulator"
HOMEPAGE="http://searchandrescue.sourceforge.net/"
SRC_URI="mirror://sourceforge/searchandrescue/${MY_PN}-${PV}.tar.gz
	mirror://sourceforge/searchandrescue/${MY_PN}-data-${MY_DATA_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXxf86vm
	x11-libs/libXmu
	x11-libs/libXi
	x11-libs/libXpm
	virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${MY_PN}-${PV}.tar.gz
	mkdir data && cd data && \
		unpack ${MY_PN}-data-${MY_DATA_PV}.tar.gz
	bunzip2 "${S}"/sar/man/${MY_PN}.6.bz2 || die
}

src_prepare() {
	sed -i \
		-e 's/@\$/$/' \
		-e 's/-o/$(LDFLAGS) -o/' \
		-e '/cpp/s/\$(CFLAGS)//' \
		-e '/LS/d' \
		sar/makefile_append.ini \
		|| die
}

src_configure() {
	export CPP="$(tc-getCXX)"
	export CPPFLAGS="${CXXFLAGS}"
	# NOTE: not an autoconf script
	./configure Linux \
		--prefix="${GAMES_PREFIX}" \
		--disable=libjsw \
		--disable=Y2 \
		|| die
	sed -i -e 's/@\$/$/' sar/Makefile || die
}

src_compile() {
	emake -C sar || die
}
src_install() {
	dogamesbin sar/${MY_PN} || die "dogamesbin failed"
	doman sar/man/${MY_PN}.6
	insinto /usr/share/icons/
	doins sar/icons/*.{ico,xpm}
	dodoc AUTHORS HACKING README
	newicon sar/icons/SearchAndRescue.xpm ${PN}.xpm
	cd "${WORKDIR}/data"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r * "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	make_desktop_entry SearchAndRescue "SearchAndRescue" \
		/usr/share/pixmaps/${PN}.xpm
	prepgamesdirs
}
