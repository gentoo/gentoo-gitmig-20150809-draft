# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spampd/spampd-2.30.ebuild,v 1.4 2011/06/15 15:40:26 phajdan.jr Exp $

DESCRIPTION="spampd is a program used within an e-mail delivery system to scan messages for possible Unsolicited Commercial E-mail content."
HOMEPAGE="http://www.worlddesign.com/index.cfm/rd/mta/spampd.htm"
SRC_URI="http://www.worlddesign.com/Content/rd/mta/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/net-server
	mail-filter/spamassassin"
DEPEND="${RDEPEND}"

src_install() {
	dosbin spampd
	dodoc changelog.txt spampd-rh-rc-script
	dohtml spampd.html
	newinitd ${FILESDIR}/init spampd
	newconfd ${FILESDIR}/conf spampd
}
