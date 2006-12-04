# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gaia/gaia-0.1.1.ebuild,v 1.2 2006/12/04 12:01:34 opfer Exp $

inherit eutils

DESCRIPTION="opensource 3D interface to the planet, based on NASA World Wind data"
HOMEPAGE="http://gaia.serezhkin.com/
	http://sourceforge.net/projects/gaia-clean"
SRC_URI="mirror://sourceforge/gaia-clean/${P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"

IUSE="gps doc"
KEYWORDS="~x86"

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
	cd "${S}"

	# This fixes a sandbox violation
	sed -i "/PREFIX\/share\/gaia/a\SConsignFile()" SConstruct

	# the doxygen instructions have the wrong input path
	use doc && epatch "${FILESDIR}/${P}-correct_doxygen_path.patch"

	# the binary would fail with a wrong hard coded path for font.png
	cd "${S}/programs/gaia/"
	epatch "${FILESDIR}/${P}-font_inclusion.patch"
}

src_compile() {
	# Due to an error in the build script, the variable CCFLAGS is expected,
	# setting it here is simpler than patching
	export CCFLAGS=${CFLAGS}
	# respect variables from the environment
	local myconf="use_env=yes"

	if use gps; then
		myconf="${myconf} gpsd=yes"
	fi

	scons ${MAKEOPTS} ${myconf} || die

	use doc && doxygen
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/gaia/

	dodoc TODO README

	if use doc; then
		rm ${S}/doc/html/*.md5
		insinto /usr/share/doc/${P}/html/
		doins ${S}/doc/html/*
	fi

	# local defines if there is installation requested, while prefix determines the
	# target 
	scons local=no  prefix="${D}/usr" install
}

pkg_postinst() {
	einfo
	einfo "please set color depth of X11 to 24 or 32 bpp"
	einfo
}