# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r1.ebuild,v 1.3 2002/07/11 06:30:47 drobbins Exp $

A=""
S=${WORKDIR}
DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

src_install() {
    dodir /etc/mail
    insinto /etc/mail
    doins ${FILESDIR}/aliases
	 insinto /etc/
	 doins ${FILESDIR}/mailcap
}
