# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libzen/libzen-0.4.23.ebuild,v 1.2 2011/11/27 04:07:20 radhermit Exp $

EAPI="4"

inherit autotools-utils multilib eutils

MY_PN="ZenLib"
DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="http://sourceforge.net/projects/zenlib"
SRC_URI="mirror://sourceforge/zenlib/${MY_PN}%20-%20Sources/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="as-is ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_PN}/Project/GNU/Library"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.21-no-tinyxml.patch
	sed -i -e "s:-O2::" configure.ac
	eautoreconf
}

src_configure() {
	econf \
		--enable-unicode \
		--enable-shared \
		$(use_enable static-libs static)
}

src_compile() {
	default

	if use doc; then
		cd "${WORKDIR}"/${MY_PN}/Source/Doc
		doxygen Doxyfile || die
	fi
}

src_install() {
	default

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${S}"/${PN}.pc

	for x in ./ Base64 Format/Html Format/Http HTTP_Client ; do
		insinto /usr/include/${MY_PN}/${x}
		doins "${WORKDIR}"/${MY_PN}/Source/${MY_PN}/${x}/*.h
	done

	dodoc "${WORKDIR}"/${MY_PN}/History.txt
	if use doc; then
		dohtml "${WORKDIR}"/${MY_PN}/Doc/*
	fi

	remove_libtool_files all
}
