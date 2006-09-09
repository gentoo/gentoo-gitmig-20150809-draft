# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-span/vdr-span-0.0.3.ebuild,v 1.1 2006/09/09 21:33:08 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Spectrum Analyzer (SpAn) PlugIn"
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
	einfo "This plugin is meant as middleware, you need appropiate"
	einfo "data-provider- as well as visualization-plugins."
}
