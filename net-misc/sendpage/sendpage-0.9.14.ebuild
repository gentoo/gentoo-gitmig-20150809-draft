# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sendpage/sendpage-0.9.14.ebuild,v 1.4 2004/11/30 22:26:37 swegener Exp $

inherit perl-module

DESCRIPTION="Dialup alphapaging software."
HOMEPAGE="http://www.sendpage.org/"
SRC_URI="http://www.sendpage.org/download/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-perl/Device-SerialPort-0.13
	>=dev-perl/MailTools-1.44
	>=dev-perl/libnet-1.11
	>=dev-perl/Net-SNPP-1.13"

mydoc="FEATURES THANKS TODO email2page.conf sendpage.cf snpp.conf docs/*"

src_install() {
	perl-module_src_install
	exeinto /etc/init.d
	newexe ${FILESDIR}/sendpage_sendpage-0.9.1 sendpage
	insinto /etc
	doins sendpage.cf
}

