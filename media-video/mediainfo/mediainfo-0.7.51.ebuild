# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mediainfo/mediainfo-0.7.51.ebuild,v 1.2 2011/12/15 13:26:00 ago Exp $

EAPI="4"
WX_GTK_VER="2.8"

inherit autotools-utils wxwidgets multilib

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="http://mediainfo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/source/${PN}/${PV}/${PN}_${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="curl mms wxwidgets"

RDEPEND="sys-libs/zlib
	media-libs/libzen
	~media-libs/lib${P}[curl=,mms=]
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

S="${WORKDIR}/MediaInfo"

pkg_setup() {
	TARGETS="CLI"
	use wxwidgets && TARGETS+=" GUI"
}

src_prepare() {
	local target
	for target in ${TARGETS}; do
		cd "${S}/Project/GNU/${target}"
		sed -i -e "s:-O2::" configure.ac
		eautoreconf
	done
}

src_configure() {
	local target
	for target in ${TARGETS}; do
		ECONF_SOURCE="${S}/Project/GNU/${target}"
		[[ ${target} == "GUI" ]] && local myeconfargs=( --with-wxwidgets --with-wx-gui )
		autotools-utils_src_configure
	done
}

src_compile() {
	local target
	for target in ${TARGETS}; do
		ECONF_SOURCE="${S}/Project/GNU/${target}"
		autotools-utils_src_compile
	done
}
src_install() {
	local target
	for target in ${TARGETS}; do
		ECONF_SOURCE="${S}/Project/GNU/${target}"
		autotools-utils_src_install
		dodoc "${S}"/History_${target}.txt
		if [[ ${target} == "GUI" ]]; then
			newicon "${S}"/Source/Ressource/Image/MediaInfo.png ${PN}.png
			make_desktop_entry ${PN}-gui MediaInfo ${PN} "AudioVideo;GTK"
		fi
	done
}
