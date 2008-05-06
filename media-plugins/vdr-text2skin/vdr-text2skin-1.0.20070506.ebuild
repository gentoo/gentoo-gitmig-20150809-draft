# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-text2skin/vdr-text2skin-1.0.20070506.ebuild,v 1.5 2008/05/06 20:35:14 zzam Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 3)
MY_BASE="text2skin-1.1-cvs_ext-0.10"
MY_P="${MY_BASE}-patched-${MY_PV}"

DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI="ftp://merkur.2y.net/pub/vdr/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="truetype direct_blit"

COMMON_DEPEND=">=media-video/vdr-1.3.18
	media-gfx/imagemagick
	truetype? ( media-libs/freetype )
	!media-plugins/vdr-text2skin-cvs"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

PATCHES=("${FILESDIR}/${MY_PV}/01_gcc-4.diff"
	"${FILESDIR}/${MY_PV}/02_uint64.diff"
	"${FILESDIR}/${MY_PV}/03_gentoo.diff"
	"${FILESDIR}/${MY_PV}/05_vdr-1.5.4.diff"
	"${FILESDIR}/${MY_PV}/06_vdr-1.5.7.diff"
	"${FILESDIR}/${MY_PV}/07_pkgconfig_magick.diff")

S="${WORKDIR}/${MY_BASE}"

SKINDIR=/usr/share/vdr/${VDRPLUGIN}
ETC_SKIN_DIR=/etc/vdr/plugins/${VDRPLUGIN}

src_unpack() {
	vdr-plugin_src_unpack unpack

	cd "${S}"
	use truetype || sed -i Makefile -e 's/^HAVE_FREETYPE/#HAVE_FREETYPE/'
	sed -i Makefile -e 's:-I\$(DVBDIR)/linux/include::'

	if ! use direct_blit; then
		epatch "${FILESDIR}/${MY_PV}/04_no_direct_blit.diff"
	fi

	vdr-plugin_src_unpack all_but_unpack
}

src_install() {
	vdr-plugin_src_install

	keepdir "${SKINDIR}"

	exeinto "${SKINDIR}/contrib"
	doexe "${S}"/contrib/skin_to_*.pl
	doexe "${S}"/contrib/transform.pl

	dodoc "${S}"/Docs/*.txt
}
