# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.33.ebuild,v 1.1 2004/10/10 01:19:01 vapier Exp $

DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_install() {
	dosbin smart{ctl,d} || die "dosbin"
	doman *.[58]
	dodoc AUTHORS CHANGELOG NEWS README TODO WARNINGS

	insinto /etc
	doins smartd.conf

	exeinto /etc/init.d; newexe ${FILESDIR}/smartd.rc smartd
	insinto /etc/conf.d; newins ${FILESDIR}/smartd.confd smartd
}
