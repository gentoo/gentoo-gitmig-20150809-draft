# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tmpreaper/tmpreaper-1.5.1.ebuild,v 1.1 2004/02/13 00:44:23 ferringb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility for removing files based on when they were last accessed"
SRC_URI="http://ftp.debian.org/debian/pool/main/t/tmpreaper/${PN}_${PV}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc "
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_install() {
	einstall || die
	dodoc debian/{ChangeLog,conffiles,copyright,cron.daily,dirs}
}
