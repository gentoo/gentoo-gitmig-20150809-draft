# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gaia/gaia-0.1.2.ebuild,v 1.8 2008/05/11 18:57:35 opfer Exp $

inherit eutils

DESCRIPTION="Opensource 3D interface to the planet, based on NASA World Wind data"
HOMEPAGE="http://sourceforge.net/projects/gaia-clean"
SRC_URI="mirror://sourceforge/gaia-clean/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"

IUSE="gps doc"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	>=media-libs/libsdl-1.2
	net-misc/curl
	virtual/opengl
	gps? ( sci-geosciences/gpsd )"

DEPEND="${RDEPEND}
	dev-util/scons
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}

	# the binary would fail with a wrong hard coded path for font.png
	cd "${S}/programs/gaia/"
	epatch "${FILESDIR}/${P}-font_inclusion.patch"

	# when linked with --as-needed it will fail checking the deps, so we just
	# remove them, as we have our own dependency checks
	cd "${S}/programs/gaia/"
	epatch "${FILESDIR}/${P}-remove_dep_checks_gaia.patch"
	cd "${S}/lib/wwfetch/"
	epatch "${FILESDIR}/${P}-remove_dep_checks_wwfetch.patch"
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
	dodir /usr/bin/
	dodir /usr/share/gaia/

	dodoc TODO README ChangeLog

	if use doc; then
		insinto /usr/share/doc/${P}/html/
		doins "${S}"/doc/html/*
	fi

	# prefix determines the target directory
	export CCFLAGS=${CFLAGS}
	scons prefix="${D}/usr" install
}
