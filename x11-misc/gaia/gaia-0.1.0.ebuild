# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gaia/gaia-0.1.0.ebuild,v 1.7 2006/11/24 17:23:02 beandog Exp $

inherit eutils

DESCRIPTION="opensource 3D interface to the planet, based on Google Earth data"
HOMEPAGE="http://gaia.serezhkin.com/"
SRC_URI="http://gaia.serezhkin.com/${P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"

IUSE="gps doc examples"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	>=media-libs/libsdl-1.2
	net-misc/curl
	virtual/opengl
	gps? ( sci-geosciences/gpsd )
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}
	dev-util/scons"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s/\.\/data/\/usr\/share\/gaia/" src/config.h
	sed -i "/libgefetch_examples/a\SConsignFile()" SConstruct
	epatch "${FILESDIR}"/${PN}-respect_CFLAGS.patch
}

src_compile() {
	local myconf=""
	if ! use gps; then
		myconf="gpsd=no"
	fi

	use examples && myconf="${myconf} libgefetch_examples=1"

	scons ${MAKEOPTS} ${myconf} || die

	use doc && doxygen
}

src_install() {
	dobin gaia
	dodoc COPYING ChangeLog README TODO

	mkdir -p "${D}/usr/share/gaia/" || die
	cp -r data/* "${D}/usr/share/gaia/" || die
	use doc && cp -r doc/html/*.{html,css,png,gif} "${D}/usr/share/doc/${PF}/"

	if use examples; then
	   mkdir "${D}/usr/share/doc/${PF}/examples"
	   cp -r libgefetch/examples/*.c "${D}/usr/share/doc/${PF}/examples"
	   cp -r libgefetch/examples/rootmeta "${D}/usr/share/doc/${PF}/examples"
	   cp -r libgefetch/examples/zerojpg "${D}/usr/share/doc/${PF}/examples"
	   cp -r libgefetch/examples/SConscript "${D}/usr/share/doc/${PF}/examples"
	fi
}

pkg_postinst() {
	einfo
	einfo "please set color depth of X11 to 24 or 32 bpp"
	einfo
}
