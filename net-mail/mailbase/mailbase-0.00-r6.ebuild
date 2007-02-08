# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r6.ebuild,v 1.20 2007/02/08 22:22:25 grobian Exp $

DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	keepdir /var/spool/mail
	fowners root:mail /var/spool/mail
	fperms 0775 /var/spool/mail
	dosym /var/spool/mail /var/mail
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
	fi

	# Always set these to close bug #8029.
	chown root:mail ${ROOT}/var/spool/mail
	chmod 0775 ${ROOT}/var/spool/mail
}
