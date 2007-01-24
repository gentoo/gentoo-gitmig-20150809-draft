# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/psmon/psmon-1.0.4.ebuild,v 1.11 2007/01/24 14:50:48 genone Exp $

DESCRIPTION="Monitors process table to slay aggressive, and spawn dead, processes"
HOMEPAGE="http://www.psmon.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
	dev-perl/config-general
	dev-perl/Proc-ProcessTable
	dev-perl/Unix-Syslog
	virtual/perl-Getopt-Long"

src_install() {
	doman psmon.1
	dohtml psmon.html
	dosbin psmon
	insinto /etc
	newins psmon.conf psmon.conf
}

pkg_postinst() {
	elog "NOTICE: Please modify at least the NotifyEmail parameter"
	elog "		found from the /etc/psmon.conf"
}
