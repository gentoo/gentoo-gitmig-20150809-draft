# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphtft/vdr-graphtft-0.1.21_alpha-r1.ebuild,v 1.3 2009/03/24 18:02:58 hd_brummy Exp $

EAPI="2"
MY_PV="${PV/_alpha/.alpha}"
MY_P="${PN}-${MY_PV}"

inherit vdr-plugin

DESCRIPTION="VDR plugin: GraphTFT"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Graphtft-plugin"
SRC_URI="http://www.jwendel.de/vdr/${MY_P}.tar.bz2
		http://www.jwendel.de/vdr/DeepBlue-horchi-0.0.8.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE="directfb graphtft-fe"

DEPEND=">=media-video/vdr-1.4.7-r9[graphtft]
		media-fonts/ttf-bitstream-vera
		media-libs/imlib2
		media-gfx/imagemagick
		gnome-base/libgtop
		>=media-video/ffmpeg-0.4.8
		directfb? ( dev-libs/DirectFB )
		graphtft-fe? ( x11-libs/qt-gui:4 )"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-gentoo.diff
		${FILESDIR}/gcc-4.3-missing_includes.diff")

S="${WORKDIR}/graphtft-${MY_PV}"

src_prepare() {
	sed -i "${WORKDIR}"/DeepBlue/DeepBlue.theme -e "s:Enigma:Vera:"
	sed -i "${S}"/themes/DeepBlue.theme -e "s:Enigma:Vera:"
	sed -i Makefile -e "s:WITH_X_COMM = 1:#WITH_X_COMM = 1:"
	sed -i common.h -e "s:void tell:int tell:"
	sed -i common.c -e "s:void tell:int tell:"

	if has_version ">=media-video/ffmpeg-0.4.9_p20070525" ; then
		sed -i Makefile -e "s:#HAVE_SWSCALE:HAVE_SWSCALE:" \
		-e "s:LIBS+=-lswscale:LIBS += -L\$\(FFMDIR\) -lswscale:"

	fi

	has_version ">=media-video/ffmpeg-0.4.9_p20080326" \
	&& epatch "${FILESDIR}/${PN}-0.1.18_alpha-ffmpeg-0.4.9_p20080326-new_header.diff"

	has_version ">=media-gfx/imagemagick-6.4" \
	&& epatch "${FILESDIR}/${PN}-0.1.18_alpha-imagemagick-6.4-new_header.diff"

	use !directfb && sed -i Makefile \
		-e "s:HAVE_DFB = 1:#HAVE_DFB = 1:"

	use graphtft-fe && sed -i Makefile \
		-e "s:#WITH_X_COMM:WITH_X_COMM:"

	vdr-plugin_src_prepare
}

src_compile() {
	vdr-plugin_src_compile

	if use graphtft-fe; then
		cd "${S}"/graphtft-fe
		sed -i build.sh -e "s:qmake-qt4:qmake:"
		./clean.sh
		./build.sh || die "build.sh failed"
	fi
}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/graphTFT/themes/DeepBlue/
	doins -r "${WORKDIR}"/DeepBlue/*
	doins "${S}"/themes/DeepBlue.theme

	dosym /usr/share/fonts/ttf-bitstream-vera /usr/share/vdr/graphTFT/fonts

	dodoc "${S}"/documents/*

	if use graphtft-fe; then
		cd "${S}"/graphtft-fe && dobin graphtft-fe
		doinit graphtft-fe
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "Graphtft-fe user:"
	elog "Edit /etc/conf.d/vdr.graphtft"
	elog "/etc/init.d/graphtft-fe start"
	echo
}
