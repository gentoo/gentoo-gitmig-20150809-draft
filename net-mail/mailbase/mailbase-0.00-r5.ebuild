# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r5.ebuild,v 1.1 2002/12/19 04:30:42 raker Exp $

S=${WORKDIR}
DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND=""

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	dodir /var/spool/mail
	chown root.mail ${D}/var/spool/mail
	chmod 1777 ${D}/var/spool/mail
	touch ${D}/var/spool/mail/.keep
	dosym /var/spool/mail /var/mail
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
		chown root.mail ${ROOT}/var/spool/mail
		chmod 1777 ${ROOT}/var/spool/mail
	fi
}
