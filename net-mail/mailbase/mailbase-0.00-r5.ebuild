# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r5.ebuild,v 1.12 2003/12/14 22:54:52 spider Exp $

S="${WORKDIR}"
DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha hppa ~arm amd64 mips"

DEPEND=""

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	keepdir /var/spool/mail
	fowners root.mail /var/spool/mail
	fperms 1777 /var/spool/mail
	dosym /var/spool/mail /var/mail
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
	fi

	# Always set these to close bug #8029.
	chown root:mail ${ROOT}/var/spool/mail
	chmod 1777 ${ROOT}/var/spool/mail
}
