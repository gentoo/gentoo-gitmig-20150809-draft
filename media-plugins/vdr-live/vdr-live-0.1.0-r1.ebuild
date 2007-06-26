# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-live/vdr-live-0.1.0-r1.ebuild,v 1.2 2007/06/26 17:21:46 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
SRC_URI="http://live.vdr-developer.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	>=dev-libs/boost-1.33.0
	>=dev-libs/tntnet-1.5.3
	>=dev-libs/cxxtools-1.4.3"

PATCHES="${FILESDIR}/${PV}/new-tntnet.diff
	${FILESDIR}/${PV}/linking.diff
	${FILESDIR}/${PV}/timerdelete.diff
	${FILESDIR}/${PV}/${P}_vdr-1.5.3-compile.diff"
