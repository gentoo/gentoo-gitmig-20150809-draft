# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-fritzbox/vdr-fritzbox-0.0.8.ebuild,v 1.2 2007/11/13 04:00:54 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Inform about incoming phone-calls and use the fritz!box phonebook from vdr menu."
HOMEPAGE="http://www.joachim-wilke.de/show.htm?alias=vdr-fritz"
SRC_URI="http://joachim-wilke.de/vdr-fritz/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"

pkg_postinst() {
	echo
	elog "The integrated call monitor (available in Fritz!Box official"
	elog "firmware releases >= xx.03.99) has to be enabled in order to"
	elog "have the vdr-fritzbox plugin display anything on your tv. To"
	elog "enable it call #96*5* from your telephone. If that doesn't"
	elog "work for you, read the documentation for further instructions."
	echo
}
