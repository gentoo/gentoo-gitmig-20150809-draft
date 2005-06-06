# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythweather/mythweather-0.17.ebuild,v 1.2 2005/06/06 09:19:53 cardoe Exp $

inherit myth

DESCRIPTION="Weather forecast module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	~media-tv/mythtv-${PV}*"

setup_pro() {
	return 0
}
