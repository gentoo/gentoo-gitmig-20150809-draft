# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-span/vdr-span-0.0.6.ebuild,v 1.1 2007/12/13 12:48:12 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Spectrum Analyzer (SpAn)"
HOMEPAGE="http://lcr.vdr-developer.org/"
SRC_URI="http://lcr.vdr-developer.org/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
		>=sci-libs/fftw-3.0.1"

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog
	elog "This plugin is meant as middleware, you need appropiate"
	elog "data-provider- as well as visualization-plugins."
}
