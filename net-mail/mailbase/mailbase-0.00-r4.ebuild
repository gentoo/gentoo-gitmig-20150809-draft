# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r4.ebuild,v 1.17 2004/07/15 01:50:07 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa mips"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	keepdir /var/spool/mail
	chown root:mail ${D}/var/spool/mail
	dosym /var/spool/mail /var/mail
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
		chown root:mail ${ROOT}/var/spool/mail
	fi
}
