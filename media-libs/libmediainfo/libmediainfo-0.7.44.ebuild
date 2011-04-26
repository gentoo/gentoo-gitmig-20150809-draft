# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmediainfo/libmediainfo-0.7.44.ebuild,v 1.1 2011/04/26 07:16:52 radhermit Exp $

EAPI="4"

inherit autotools-utils multilib

MY_PN="MediaInfo"
DESCRIPTION="MediaInfo libraries"
HOMEPAGE="http://mediainfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/mediainfo/source/${PN}/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug doc libmms static-libs"

RDEPEND="sys-libs/zlib
	>=media-libs/libzen-0.4.18[static-libs=]
	curl? ( net-misc/curl )
	libmms? ( >=media-libs/libmms-0.6.1[static-libs=] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

AUTOTOOLS_IN_SOURCE_BUILD=1

S="${WORKDIR}/${MY_PN}Lib/Project/GNU/Library"

src_prepare() {
	# Don't force -O2 by default
	sed -i -e "s:-O2::" configure.ac

	eautoreconf
}

src_configure() {
	local myeconfargs
	myeconfargs=(
		$(use_with curl libcurl)
		$(use_with libmms)
		$(use_enable static-libs staticlibs)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc; then
		cd "${WORKDIR}/${MY_PN}Lib/Source/Doc"
		doxygen Doxyfile || die
	fi
}

src_install() {
	autotools-utils_src_install

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${S}"/${PN}.pc

	for x in ./ Archive Audio Duplicate Export Image Multiple Reader Tag Text Video; do
		insinto /usr/include/${MY_PN}/${x}
		doins "${WORKDIR}"/${MY_PN}Lib/Source/${MY_PN}/${x}/*.h
	done

	dodoc "${WORKDIR}"/${MY_PN}Lib/*.txt
	if use doc; then
		dohtml -r "${WORKDIR}"/${MY_PN}Lib/Doc/*
	fi
}
