# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.0.9.ebuild,v 1.1 2006/01/09 21:45:42 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="DVB Radio with RDS Text plugin for VDR >= 1.3.21"
HOMEPAGE="http://vdrportal.de/board/thread.php?threadid=37042"
SRC_URI="http://mirror/gentoo/${P}.tgz
	http://mirror/gentoo/radioimages_rtext-kleo2.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"

src_install() {

	vdr-plugin_src_install

	insinto /usr/share/vdr/radio
	newins ${WORKDIR}/rtextOben-kleo2.mpg radio.mpg
}
