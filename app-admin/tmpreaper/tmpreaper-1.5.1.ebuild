# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpreaper/tmpreaper-1.5.1.ebuild,v 1.1 2005/03/05 00:43:49 ciaranm Exp $

DESCRIPTION="A utility for removing files based on when they were last accessed"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
SRC_URI="mirror://debian/pool/main/t/tmpreaper/${PN}_${PV}.tar.gz"

KEYWORDS="amd64 ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	einstall || die
	dodoc README Changelog debian/{cron.daily,tmpreaper.conf}
}
