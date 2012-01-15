# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-text2skin/vdr-text2skin-1.3.1.ebuild,v 1.3 2012/01/15 19:31:24 idl0r Exp $

EAPI="2"

inherit vdr-plugin versionator

UPLOAD_NR=344 # changes with every version / new file :-(

DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-text2skin"
SRC_URI="mirror://vdr-developerorg/${UPLOAD_NR}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
#IUSE="truetype direct_blit"
IUSE="+truetype"

COMMON_DEPEND=">=media-video/vdr-1.6.0
	media-gfx/imagemagick
	truetype? ( media-libs/freetype )"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

SKINDIR=/usr/share/vdr/${VDRPLUGIN}
ETC_SKIN_DIR=/etc/vdr/plugins/${VDRPLUGIN}

src_prepare() {
	sed -i common.c -e 's#cPlugin::ConfigDirectory(PLUGIN_NAME_I18N)#"/usr/share/vdr/"PLUGIN_NAME_I18N#'

	sed -i bitmap.c -e "s:8U:(size_t)8U:"

	use truetype || sed -i Makefile -e 's/^HAVE_FREETYPE/#HAVE_FREETYPE/'

	if ! has_version ">=media-video/vdr-1.7.13"; then
		sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile
	fi

	vdr-plugin_src_prepare
}

src_install() {
	vdr-plugin_src_install

	keepdir "${SKINDIR}"

	exeinto "${SKINDIR}/contrib"
	doexe "${S}"/contrib/skin_to_*.pl
	doexe "${S}"/contrib/transform.pl

	dodoc "${S}"/Docs/*.txt
}
