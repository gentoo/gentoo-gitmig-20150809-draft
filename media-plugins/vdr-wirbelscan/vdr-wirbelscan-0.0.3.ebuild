# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-wirbelscan/vdr-wirbelscan-0.0.3.ebuild,v 1.2 2007/09/10 00:35:44 mr_bones_ Exp $

inherit vdr-plugin

MY_P=${P}_20070903

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://free.pages.at/wirbel4vdr/wirbelscan/index2.html"
SRC_URI="http://free.pages.at/wirbel4vdr/wirbelscan/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	!<media-tv/ivtv-0.8"

S="${WORKDIR}/${MY_P#vdr-}"
