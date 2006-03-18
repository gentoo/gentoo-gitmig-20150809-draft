# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spampd/spampd-2.30.ebuild,v 1.1 2006/03/18 01:07:13 ticho Exp $

DESCRIPTION="spampd is a program used within an e-mail delivery system to scan messages for possible Unsolicited Commercial E-mail content."
HOMEPAGE="http://www.worlddesign.com/index.cfm/rd/mta/spampd.htm"
SRC_URI="http://www.worlddesign.com/Content/rd/mta/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/net-server
	mail-filter/spamassassin"
DEPEND="${RDEPEND}"

src_install() {
	dosbin spampd
	dodoc changelog.txt spampd-rh-rc-script
	dohtml spampd.html
	exeinto /etc/init.d/
	newexe ${FILESDIR}/init spampd
	insinto /etc/conf.d
	newins ${FILESDIR}/conf spampd
}
