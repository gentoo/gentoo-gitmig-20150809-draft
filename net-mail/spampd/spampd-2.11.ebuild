# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/spampd/spampd-2.11.ebuild,v 1.2 2004/01/05 11:34:52 robbat2 Exp $

DESCRIPTION="spampd is a program used within an e-mail delivery system to scan messages for possible Unsolicited Commercial E-mail content."
HOMEPAGE="http://www.worlddesign.com/index.cfm/rd/mta/spampd.htm"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/net-server
	dev-perl/Mail-SpamAssassin"

S=${WORKDIR}/${P}

src_install() {
	dosbin spampd
	dodoc COPYING README.Gentoo changelog.txt spampd-rh-rc-script
	dohtml spampd.html
	exeinto /etc/init.d/
	newexe ${FILESDIR}/init spampd
	insinto /etc/conf.d
	newins ${FILESDIR}/conf spampd
}
