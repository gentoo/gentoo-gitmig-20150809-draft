# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpreaper/tmpreaper-1.6.6.ebuild,v 1.1 2006/10/19 19:17:48 seemant Exp $

DESCRIPTION="A utility for removing files based on when they were last accessed"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
SRC_URI="mirror://debian/pool/main/t/tmpreaper/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die "make installl failed"
	dodoc README ChangeLog debian/{cron.daily,tmpreaper.conf,README*}
}
