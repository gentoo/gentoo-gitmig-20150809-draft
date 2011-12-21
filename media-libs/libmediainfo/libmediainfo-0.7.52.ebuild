# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmediainfo/libmediainfo-0.7.52.ebuild,v 1.1 2011/12/21 20:17:43 radhermit Exp $

EAPI="4"

inherit autotools multilib flag-o-matic eutils

MY_PN="MediaInfo"
DESCRIPTION="MediaInfo libraries"
HOMEPAGE="http://mediainfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/mediainfo/source/${PN}/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl doc mms static-libs"

RDEPEND="sys-libs/zlib
	>=dev-libs/tinyxml-2.6.2[stl]
	>=media-libs/libzen-0.4.23[static-libs=]
	curl? ( net-misc/curl )
	mms? ( >=media-libs/libmms-0.6.1[static-libs=] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_PN}Lib/Project/GNU/Library"

src_prepare() {
	pushd "${WORKDIR}"/${MY_PN}Lib > /dev/null
	epatch "${FILESDIR}"/${PN}-0.7.48-system-tinyxml.patch
	popd > /dev/null

	# Don't force -O2 by default
	sed -i -e "s:-O2::" configure.ac

	append-flags -DMEDIAINFO_LIBMMS_DESCRIBE_SUPPORT=0
	append-flags -DTIXML_USE_STL
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		$(use_with curl libcurl) \
		$(use_with mms libmms) \
		$(use_enable static-libs static) \
		$(use_enable static-libs staticlibs)
}

src_compile() {
	default

	if use doc; then
		cd "${WORKDIR}/${MY_PN}Lib/Source/Doc"
		doxygen Doxyfile || die
	fi
}

src_install() {
	default

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${S}"/${PN}.pc

	for x in ./ Archive Audio Duplicate Export Image Multiple Reader Tag Text Video; do
		insinto /usr/include/${MY_PN}/${x}
		doins "${WORKDIR}"/${MY_PN}Lib/Source/${MY_PN}/${x}/*.h
	done

	insinto /usr/include/${MY_PN}DLL
	doins "${WORKDIR}"/${MY_PN}Lib/Source/${MY_PN}DLL/*.h

	dodoc "${WORKDIR}"/${MY_PN}Lib/*.txt
	if use doc; then
		dohtml -r "${WORKDIR}"/${MY_PN}Lib/Doc/*
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}
