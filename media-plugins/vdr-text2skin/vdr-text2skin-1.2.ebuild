# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-text2skin/vdr-text2skin-1.2.ebuild,v 1.2 2012/01/15 19:31:24 idl0r Exp $

EAPI="1"

inherit vdr-plugin versionator

DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-text2skin"
SRC_URI="mirror://vdr-developerorg/112/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
#IUSE="truetype direct_blit"
IUSE="+truetype"

COMMON_DEPEND=">=media-video/vdr-1.3.18
	media-gfx/imagemagick
	!media-plugins/vdr-text2skin-cvs
	truetype? ( media-libs/freetype )"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

SKINDIR=/usr/share/vdr/${VDRPLUGIN}
ETC_SKIN_DIR=/etc/vdr/plugins/${VDRPLUGIN}

src_unpack() {
	vdr-plugin_src_unpack unpack

	cd "${S}"

	sed -i common.c -e 's#cPlugin::ConfigDirectory(PLUGIN_NAME_I18N)#"/usr/share/vdr/"PLUGIN_NAME_I18N#'

	use truetype || sed -i Makefile -e 's/^HAVE_FREETYPE/#HAVE_FREETYPE/'

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
