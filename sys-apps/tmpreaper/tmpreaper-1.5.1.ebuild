# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tmpreaper/tmpreaper-1.5.1.ebuild,v 1.8 2004/10/17 11:24:55 absinthe Exp $

DESCRIPTION="A utility for removing files based on when they were last accessed"
SRC_URI="mirror://debian/pool/main/t/tmpreaper/${PN}_${PV}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
KEYWORDS="x86 amd64 ppc sparc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"

src_install() {
	einstall || die
	dodoc debian/{ChangeLog,conffiles,copyright,cron.daily,dirs}
}
