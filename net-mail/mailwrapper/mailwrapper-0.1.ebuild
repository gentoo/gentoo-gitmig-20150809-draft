# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailwrapper/mailwrapper-0.1.ebuild,v 1.1 2004/03/09 03:25:47 g2boojum Exp $

DESCRIPTION="Program to invoke an appropriate MTA based on a config file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${P}

pkg_setup() {
	if [ -f "/usr/sbin/sendmail" ]
	then
		einfo "This ebuild will install a new /usr/sbin/sendmail."
		einfo "Please move the current one out of the way first."
		die
	fi
}

src_compile() {
	gcc ${CFLAGS} -o mailwrapper mailwrapper.c fparseln.c fgetln.c \
		|| die "gcc failed"
}

src_install() {
	newsbin mailwrapper sendmail
	doman mailer.conf.5 mailwrapper.8
	dodir /etc
	insinto /etc
	doins mailer.conf
}
