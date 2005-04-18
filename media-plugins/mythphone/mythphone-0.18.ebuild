# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.18.ebuild,v 1.1 2005/04/18 08:18:00 eradicator Exp $

inherit myth eutils

DESCRIPTION="Phone and video calls with SIP."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"
	# festival? ( app-accessibility/festival )


setup_pro() {
	return 0
}

src_compile() {
	# currently broken, #64503
	#myconf=$(use_enable festival)

	myth_src_compile
}
