# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/krecord/krecord-1.11.ebuild,v 1.8 2004/06/29 11:13:50 carlo Exp $

inherit kde

DESCRIPTION="KDE sound recorder app"
HOMEPAGE="http://bytesex.org/krecord.html"
SRC_URI="http://bytesex.org/misc/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

#RDEPEND="media-libs/alsa-lib"
need-kde 3

src_install() {

	cd ${S}
	make prefix=${D}/${PREFIX} install

}
