# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-span/vdr-span-0.0.3.ebuild,v 1.3 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Spectrum Analyzer (SpAn)"
HOMEPAGE="http://lcr.vdr-developer.org/"
SRC_URI="http://lcr.vdr-developer.org/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
		>=sci-libs/fftw-3.0.1"

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "This plugin is meant as middleware, you need appropiate"
	elog "data-provider- as well as visualization-plugins."
}
