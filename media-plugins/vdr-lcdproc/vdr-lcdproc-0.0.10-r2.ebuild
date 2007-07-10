# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcdproc/vdr-lcdproc-0.0.10-r2.ebuild,v 1.1 2007/07/10 17:43:07 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: use LCD device for additional output"
HOMEPAGE="http://home.pages.at/linux/dvb.html"
SRC_URI="http://home.pages.at/linux/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0
		>=app-misc/lcdproc-0.4.3"

src_unpack() {
	vdr-plugin_src_unpack

	if has_version ">=media-video/vdr-1.3.18" ; then
		epatch "${FILESDIR}/${P}-vdr-1.3.18.diff"
	fi
}
