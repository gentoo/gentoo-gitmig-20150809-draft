# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-premiereepg/vdr-premiereepg-0.2.0.ebuild,v 1.1 2008/12/09 20:25:37 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: Support the extended EPG which is sent by german paytv Premiere on their portal channels"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# This plugin uses the libsi-code fixed in v1.4.0-3
DEPEND=">=media-video/vdr-1.4.1"
RDEPEND="${DEPEND}"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	fix_vdr_libsi_include premiereepg.c
}

