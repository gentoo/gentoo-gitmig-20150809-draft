# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailwrapper/mailwrapper-0.2.ebuild,v 1.1 2004/05/30 18:45:06 g2boojum Exp $

inherit gcc

DESCRIPTION="Program to invoke an appropriate MTA based on a config file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND=""

src_compile() {
	$(gcc-getCC) ${CFLAGS} \
		-o mailwrapper \
		mailwrapper.c fparseln.c fgetln.c \
		|| die "build failed"
}

src_install() {
	newsbin mailwrapper sendmail || die "mailwrapper binary not installed"
	doman mailer.conf.5 mailwrapper.8
	insinto /etc/mail
	doins ${FILESDIR}/mailer.conf || die "mailer.conf not installed"
}

pkg_postinst() {
	if [[ -e /etc/mailer.conf ]]
	then
		einfo
		einfo "The mailwrapper config file has moved to /etc/mail/mailer.conf,"
		einfo "so the /etc/mailer.conf file on your system is no longer used."
		einfo
	fi
}
