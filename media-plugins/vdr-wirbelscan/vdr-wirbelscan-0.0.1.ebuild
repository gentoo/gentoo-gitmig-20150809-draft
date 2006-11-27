# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-wirbelscan/vdr-wirbelscan-0.0.1.ebuild,v 1.1 2006/11/27 12:27:21 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Wirbelscan-plugin"
SRC_URI="http://free.pages.at/wirbel4vdr/wirbelscan/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	!<media-tv/ivtv-0.8"

PATCHES="${FILESDIR}/${P}-include.diff"


