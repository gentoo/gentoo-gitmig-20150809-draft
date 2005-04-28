# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailfront/mailfront-0.93.ebuild,v 1.1 2005/04/28 21:02:25 anarchy Exp $

inherit toolchain-funcs

DESCRIPTION="Mail server network protocol front-ends"
HOMEPAGE="http://untroubled.org/mailfront/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/bglibs-1.017"
RDEPEND="mail-mta/qmail
	 net-libs/cvm"

src_compile() {
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "/var/qmail/bin" > conf-bin
	echo "/var/qmail" > conf-qmail
	echo "${D}/var/qmail/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) -s" > conf-ld
	make || die
}

src_install() {
	dodir /var/qmail/bin
	./installer || die

	exeinto /var/qmail/supervise/qmail-smtpd
	newexe ${FILESDIR}/run-smtpfront run.mailfront
	exeinto /var/qmail/supervise/qmail-pop3d
	newexe ${FILESDIR}/run-pop3front run.mailfront

	dodoc ANNOUNCEMENT COPYING ChangeLog NEWS README VERSION
	dohtml *.html
}

pkg_config() {
	cd /var/qmail/supervise/qmail-smtpd/
	cp run run.qmail-smtpd.`date +%Y%m%d%H%M%S` && cp run.mailfront run
	cd /var/qmail/supervise/qmail-pop3d/
	cp run run.qmail-pop3d.`date +%Y%m%d%H%M%S` && cp run.mailfront run
}

pkg_postinst() {
	echo
	einfo "Run "
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to update your run files (backups are created) in"
	einfo "		/var/qmail/supervise/qmail-pop3d and"
	einfo "		/var/qmail/supervise/qmail-smtpd"
	echo
}
