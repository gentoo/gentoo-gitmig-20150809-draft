# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-premiereepg/vdr-premiereepg-0.0.8.ebuild,v 1.3 2008/04/29 11:38:16 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: Support the extended EPG which is sent by german paytv Premiere on their portal channels"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

# This plugin uses the libsi-code fixed in v1.4.0-3
DEPEND=">=media-video/vdr-1.4.1"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-fix-epg.patch")

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	fix_vdr_libsi_include premiereepg.c
	sed -i Makefile -e "s:i18n.c:i18n.h:"
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	ewarn "You should delete your existing /var/vdr/video/epg.data,"
	ewarn "as the Handling of event-IDs has been changed in this release."
}
