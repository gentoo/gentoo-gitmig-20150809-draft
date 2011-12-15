# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libzen/libzen-0.4.23.ebuild,v 1.6 2011/12/15 13:21:44 ago Exp $

EAPI="4"

inherit autotools-utils multilib

MY_PN="ZenLib"
DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="http://sourceforge.net/projects/zenlib"
SRC_URI="mirror://sourceforge/zenlib/${MY_PN}%20-%20Sources/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="as-is ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_PN}/Project/GNU/Library"

PATCHES=(
	"${FILESDIR}"/${PN}-0.4.21-no-tinyxml.patch
)

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	autotools-utils_src_prepare
	sed -i -e "s:-O2::" configure.ac
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-unicode
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

	if use doc ; then
		cd "${WORKDIR}"/${MY_PN}/Source/Doc
		doxygen Doxyfile || die
	fi
}

src_install() {
	autotools-utils_src_install

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${AUTOTOOLS_BUILD_DIR}"/${PN}.pc

	for x in ./ Base64 Format/Html Format/Http HTTP_Client ; do
		insinto /usr/include/${MY_PN}/${x}
		doins "${WORKDIR}"/${MY_PN}/Source/${MY_PN}/${x}/*.h
	done

	dodoc "${WORKDIR}"/${MY_PN}/History.txt
	if use doc ; then
		dohtml "${WORKDIR}"/${MY_PN}/Doc/*
	fi
}
