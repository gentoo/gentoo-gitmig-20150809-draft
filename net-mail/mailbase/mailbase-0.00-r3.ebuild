# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r3.ebuild,v 1.1 2002/05/12 21:06:40 azarah Exp $

S=${WORKDIR}
SLOT="0"
DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	dodir /var/spool/mail
	chown root.mail ${D}/var/spool/mail
	dosym /var/spool/mail /var/mail
}
