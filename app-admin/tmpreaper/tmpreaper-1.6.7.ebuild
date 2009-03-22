# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpreaper/tmpreaper-1.6.7.ebuild,v 1.3 2009/03/22 01:29:24 jmbsvicetto Exp $

inherit eutils

DESCRIPTION="A utility for removing files based on when they were last accessed"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper"
SRC_URI="mirror://debian/pool/main/t/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fix-protect.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog debian/{cron.daily,tmpreaper.conf,README*}
}
