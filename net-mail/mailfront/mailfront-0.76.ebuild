# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailfront/mailfront-0.76.ebuild,v 1.9 2004/01/05 23:03:24 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail server network protocol front-ends."
SRC_URI="http://untroubled.org/mailfront/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/mailfront/"

DEPEND="virtual/glibc
	dev-libs/bglibs"

RDEPEND="net-mail/cvm-vmailmgr
	net-mail/qmail"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "

src_compile() {
	cd ${S}
	echo "/var/qmail/bin" > conf-bin
	echo "${CC} ${CFLAGS} -I/usr/lib/bglibs/include" > conf-cc
	echo "${CC} -s -L/usr/lib/bglibs/lib" > conf-ld
	emake || die
}

src_install () {
	exeinto /var/qmail/bin
	doexe pop3front-auth pop3front-maildir smtpfront-echo smtpfront-qmail smtpfront-reject imapfront-auth

	#install new run files for qmail-smtpd and qmail-pop3
	exeinto /var/qmail/supervise/qmail-smtpd
	newexe ${FILESDIR}/run-smtpfront run

	exeinto /var/qmail/supervise/qmail-pop3d
	newexe ${FILESDIR}/run-pop3front run

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION
}

pkg_postinst() {
	echo -e "\e[32;01m Now you need to restart qmail-smtpd and qmail-pop3d services:\033[0m"
	echo '   $ svc -t /service/qmail-smtpd && svc -t /service/qmail-pop3d'
	echo
}
