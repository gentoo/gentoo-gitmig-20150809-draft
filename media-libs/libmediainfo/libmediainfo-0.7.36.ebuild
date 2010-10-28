# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmediainfo/libmediainfo-0.7.36.ebuild,v 1.1 2010/10/28 07:07:58 radhermit Exp $

EAPI="2"

inherit autotools multilib

MY_PN="MediaInfo"
DESCRIPTION="MediaInfo libraries"
HOMEPAGE="http://mediainfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/mediainfo/source/${PN}/${PV}/${PN}_${PV}.tar.bz2"

S="${WORKDIR}/${MY_PN}Lib/Project/GNU/Library"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug doc libmms static-libs"

RDEPEND="sys-libs/zlib
	>=media-libs/libzen-0.4.14[static-libs=]
	curl? ( net-misc/curl )
	libmms? ( >=media-libs/libmms-0.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	# https://bugs.launchpad.net/libmms/+bug/531326
	sed -i -e 's/mmsx/mms/g' \
		"${WORKDIR}/${MY_PN}Lib/Source/MediaInfo/Reader/Reader_libmms.cpp" \
		|| die "sed failed"

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable debug) \
		$(use_with curl libcurl) \
		$(use_with libmms) \
		$(use_enable static-libs static) \
		$(use_enable static-libs staticlibs)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${WORKDIR}/${MY_PN}Lib/Source/Doc"
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	einstall

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${PN}.pc" || die

	for x in ./ Archive Audio Duplicate Export Image Multiple Reader Tag Text Video; do
		insinto "/usr/include/${MY_PN}/${x}"
		doins "${WORKDIR}/${MY_PN}Lib/Source/${MY_PN}/${x}/"*.h || die
	done

	dodoc "${WORKDIR}/${MY_PN}Lib/"*.txt
	if use doc; then
		dohtml "${WORKDIR}/${MY_PN}Lib/Source/Doc/Documentation.html" || die
		dohtml -r "${WORKDIR}/${MY_PN}Lib/Doc" || die
	fi
}
