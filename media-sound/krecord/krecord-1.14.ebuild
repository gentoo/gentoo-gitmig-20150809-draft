# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/krecord/krecord-1.14.ebuild,v 1.7 2004/06/29 11:13:50 carlo Exp $

inherit kde

DESCRIPTION="KDE sound recorder app"
HOMEPAGE="http://bytesex.org/krecord.html"
SRC_URI="http://bytesex.org/misc/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

need-kde 3
#RDEPEND="media-libs/alsa-lib"

src_compile() {
	emake || die
}

src_install() {
	cd ${S}
	make prefix=${D}/${PREFIX} install
}
