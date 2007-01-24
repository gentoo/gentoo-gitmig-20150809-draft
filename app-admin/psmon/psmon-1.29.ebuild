# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/psmon/psmon-1.29.ebuild,v 1.6 2007/01/24 14:50:48 genone Exp $

inherit perl-app

DESCRIPTION="Monitors process table to slay aggressive, and spawn dead, processes"
HOMEPAGE="http://www.psmon.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
	dev-perl/config-general
	dev-perl/Proc-ProcessTable
	dev-perl/Unix-Syslog
	virtual/perl-Getopt-Long"

src_install() {
	perl-module_src_install
	insinto /etc
	doins etc/psmon.conf
}

pkg_postinst() {
	elog "NOTICE: Please modify at least the NotifyEmail parameter"
	elog "		found from the /etc/psmon.conf"
}
