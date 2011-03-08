# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmediainfo/libmediainfo-0.7.41.ebuild,v 1.2 2011/03/08 18:26:44 hwoarang Exp $

EAPI="3"

inherit autotools multilib eutils

MY_PN="MediaInfo"
DESCRIPTION="MediaInfo libraries"
HOMEPAGE="http://mediainfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/mediainfo/source/${PN}/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="curl debug doc libmms static-libs"

RDEPEND="sys-libs/zlib
	>=media-libs/libzen-0.4.14[static-libs=]
	curl? ( net-misc/curl )
	libmms? ( >=media-libs/libmms-0.6.1[static-libs=] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_PN}Lib/Project/GNU/Library"

src_prepare() {
	# Fix linking problem for bug #343125
	EPATCH_OPTS="-p1 -d ${WORKDIR}/${MY_PN}Lib" epatch "${FILESDIR}"/${P}-curl.patch
	eautoreconf
}

src_configure() {
	local myconf
	use debug && myconf="${myconf} --enable-debug"
	use curl && myconf="${myconf} --with-libcurl"
	use libmms && myconf="${myconf} --with-libmms"
	use static-libs && myconf="${myconf} --enable-staticlibs"

	econf \
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable static-libs static) \
		${myconf}
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${WORKDIR}/${MY_PN}Lib/Source/Doc"
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

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
