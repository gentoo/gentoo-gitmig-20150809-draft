# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ktvschedule/ktvschedule-0.1.9.1.ebuild,v 1.1 2006/10/24 14:18:37 beandog Exp $

inherit kde
DESCRIPTION="KDE frontend for TV listings guide grabbers xmltv and nxtvpeg"
HOMEPAGE="http://ktvschedule.berlios.de/"
# SRC_URI hardcoded because of an upstream tarring bug
SRC_URI="http://download.berlios.de/ktvschedule/ktvschedule-0.1.9.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="|| ( media-tv/nxtvepg media-tv/xmltv )
		|| ( kde-base/kdepim kde-base/korganizer kde-base/kalarm )"

need-kde 3

src_install() {
	emake DESTDIR="${D}" install || die "emake install died"
	dodoc AUTHORS ChangeLog README TODO
}
