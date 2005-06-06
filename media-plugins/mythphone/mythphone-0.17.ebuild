# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.17.ebuild,v 1.3 2005/06/06 09:16:48 cardoe Exp $

inherit myth eutils

DESCRIPTION="Phone and video calls with SIP."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	~media-tv/mythtv-${PV}"

setup_pro() {
	return 0
}

src_compile() {
	econf || die

	# currently broken, #64503
	#`use_enable festival`

	myth_src_compile
}
