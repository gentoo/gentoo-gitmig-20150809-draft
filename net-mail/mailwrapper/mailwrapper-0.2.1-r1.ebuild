# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailwrapper/mailwrapper-0.2.1-r1.ebuild,v 1.6 2005/07/04 23:11:37 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="Program to invoke an appropriate MTA based on a config file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE=""

DEPEND=""

src_compile() {
	$(tc-getCC) ${CFLAGS} \
		-o mailwrapper \
		mailwrapper.c fparseln.c fgetln.c \
		|| die "build failed"
}

src_install() {
	dodir /usr/sbin /usr/bin /usr/lib
	newsbin mailwrapper sendmail || die "mailwrapper binary not installed"
	dohard /usr/sbin/sendmail /usr/bin/newaliases
	dohard /usr/sbin/sendmail /usr/bin/mailq
	dohard /usr/sbin/sendmail /usr/bin/rmail
	dosym /usr/sbin/sendmail /usr/lib/sendmail
	doman mailer.conf.5 mailwrapper.8
}
