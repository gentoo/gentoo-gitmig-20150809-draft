# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/psmon/psmon-1.0.4.ebuild,v 1.2 2004/02/29 23:02:45 pyrania Exp $

DESCRIPTION="Monitors process table to slay aggressive, and spawn dead, processes"
HOMEPAGE="http://psmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
RESTRICT="nomirror"

LICENSE="GPL-1"
SLOT="0"

KEYWORDS="x86"
IUSE=""
DEPEND=">=perl-5.6.0
	dev-perl/config-general
	dev-perl/Proc-ProcessTable
	dev-perl/Unix-Syslog
	dev-perl/Getopt-Long"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
}

src_install() {
	doman psmon.1
	dohtml psmon.html
	dosbin psmon
	insinto /etc
	newins psmon.conf psmon.conf
}

pkg_postinst() {
	einfo "NOTICE: Please modify at least the NotifyEmail parameter"
	einfo "		found from the /etc/psmon.conf"
}
