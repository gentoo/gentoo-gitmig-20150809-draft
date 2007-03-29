# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailwrapper/mailwrapper-0.2.1.ebuild,v 1.8 2007/03/29 14:59:59 drizzt Exp $

inherit toolchain-funcs

DESCRIPTION="Program to invoke an appropriate MTA based on a config file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_compile() {
	$(tc-getCC) ${CFLAGS} \
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
