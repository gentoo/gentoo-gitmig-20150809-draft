# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailfront/mailfront-0.85.ebuild,v 1.1 2003/05/09 17:55:02 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail server network protocol front-ends."
SRC_URI="http://untroubled.org/mailfront/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/mailfront/"

DEPEND="virtual/glibc
	>=dev-libs/bglibs-1.006"

RDEPEND="net-mail/cvm-vmailmgr
	net-mail/qmail
	net-mail/qmail-pop3d"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

src_compile() {
	cd ${S}
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "/var/qmail/bin" > conf-bin
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc -s" > conf-ld
	emake || die
}

src_install () {
	exeinto /var/qmail/bin
	doexe pop3front-auth pop3front-maildir smtpfront-echo \
		smtpfront-qmail smtpfront-reject imapfront-auth \
		qmqpfront-qmail qmtpfront-qmail

	#install new run files for qmail-smtpd and qmail-pop3
	exeinto /var/qmail/supervise/qmail-smtpd
	newexe ${FILESDIR}/run-smtpfront run.mailfront
	exeinto /var/qmail/supervise/qmail-pop3d
	newexe ${FILESDIR}/run-pop3front run.mailfront

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION

	dohtml cvm-sasl.html imapfront.html mailfront.html mailrules.html \
		mailrules2.html pop3front.html qmail-backend.html \
		qmail-validate.html smtpfront.html
}

pkg_config() {
	cd /var/qmail/supervise/qmail-smtpd/
	cp run run.old && cp run.mailfront run
	
	cd /var/qmail/supervise/qmail-pop3d/
	cp run run.old && cp run.mailfront run
}

pkg_postinst() {
	einfo ""
	einfo "Run ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to update you run files (backup are created) in" 
	einfo "		/var/qmail/supervise/qmail-pop3d and"
	einfo "		/var/qmail/supervise/qmail-smtpd"
}
