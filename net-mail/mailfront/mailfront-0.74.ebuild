# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}

DEPEND="virtual/glibc"

RDEPEND="net-mail/cvm-vmailmgr
	net-mail/qmail
	net-mail/qmail-pop3d"

DESCRIPTION="Mail server network protocol front-ends."
SRC_URI="http://untroubled.org/mailfront/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/mailfront/"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
}

src_install () {
	exeinto /var/qmail/bin
	doexe pop3front-auth pop3front-maildir smtpfront-echo smtpfront-qmail smtpfront-reject

	#install new run files for qmail-smtpd and qmail-pop3
	exeinto /var/qmail/supervise/qmail-smtpd
	newexe ${FILESDIR}/run-smtpfront run

	exeinto /var/qmail/supervise/qmail-pop3d
	newexe ${FILESDIR}/run-pop3front run

}

pkg_postinst() {
	echo -e "\e[32;01m Now you need to restart qmail-smtpd and qmail-pop3d services:\033[0m"
	echo '   $ svc -t /service/qmail-smtpd && svc -t /service/qmail-pop3d'
	echo
}